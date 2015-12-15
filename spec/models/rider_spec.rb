require 'rails_helper'

RSpec.describe Rider, type: :model do
  
  it "can find closest available car" do
    rider = create :rider
    expect(rider.lat).to be_truthy 
    expect(rider.lng).to be_truthy 
    #no car created
    car = Car.available.closest origin: rider
    expect(car).to be_empty
    
    first_car = create :car, available: false
    car = Car.available.closest origin: rider
    expect(car).to be_empty
    
    first_car.available = true
    first_car.save
    
    car = Car.available.closest(origin: rider).first
    expect(car).to eq first_car
    
  end
  
  it "can calculate distance to car" do
    rider = create :rider
    car = create :car
    distance = car.distance_from rider
    expect(distance).to be > 0
  end
  
  it 'can book closet car available for a ride' do
    rider = create :rider
    ride = rider.book    
    expect(ride).to be_falsey
    
    car = create :car
    ride = rider.book   
    expect(ride.riders.first).to eq rider
    expect(ride.car).to eq car
    expect(ride.pool).to eq false
    car.reload
    expect(ride.car.available).to eq false
  end
  
  it "can book a shared pool ride for pool rides" do
    
    # pool ride gets first rider
    rider = create :rider
    car = create :car
    ride = rider.book(1, true)
    
    expect(ride.riders.first).to eq rider
    expect(ride.car).to eq car
    expect(ride.pool).to eq true
    expect(ride.passengers).to eq 1
    expect(ride.car.available).to eq false
    expect(ride.available_to_pool).to eq true
    
    #pool ride gets second rider
    rider2 = create :rider
    ride2 = rider.book(1, true)
    
    expect(ride2).to eq ride
    expect(ride2.riders.count).to eq 2
    expect(ride2.car).to eq car
    expect(ride2.passengers).to eq 2
    expect(ride2.pool).to eq true
    expect(ride2.available_to_pool).to eq true
    
    #same pool ride gets third rider + friend = car now full
    rider3 = create :rider
    ride3 = rider.book(2, true)
    
    expect(ride3).to eq ride
    expect(ride3.riders.count).to eq 3
    expect(ride3.car).to eq car
    expect(ride3.passengers).to eq 4
    expect(ride3.passengers).to eq car.seats
    expect(ride3.pool).to eq true
    expect(ride3.available_to_pool).to eq false
    
    # new pool request will book new ride
    rider4 = create :rider
    car2 = create :car
    ride4 = rider4.book(1, true)
    
    expect(ride4.riders.first).to eq rider4
    expect(ride4.car).to eq car2
    expect(ride4.pool).to eq true
    expect(ride4.passengers).to eq 1
    expect(ride4.car.available).to eq false
    expect(ride4.available_to_pool).to eq true
    
  end  
end
