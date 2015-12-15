class Rider < ActiveRecord::Base
  has_and_belongs_to_many :rides
  acts_as_mappable
  
  
  def book(passengers=1, pool=false)
    if pool
      ride = Ride.available_to_pool.closest(origin: self).first 
      if ride
        if ride.add_passengers(self, passengers)
          # can add passenger
          ride
        else
          find_next_closest_ride_available(passengers)
        end
      else
        book_empty_car(passengers, pool)
      end
    else
      book_empty_car(passengers, pool)
    end
    
  end
  
  
  def find_next_closest_ride_available(passengers)
    # outside scope, book empty car for now
    book_empty_car(passengers, true)
  end
  
  def book_empty_car(passengers, pool)
    
    car = Car.available.closest(origin: self).first
    if car
      # find closest ride to pool
      ride ||= Ride.create! driver: car.driver, pool: pool, passengers: passengers
      ride.update_location
      ride.riders << self
      ride.available_to_pool!
      car.not_available! 
      ride
    else
      nil
    end
  end
  
end
