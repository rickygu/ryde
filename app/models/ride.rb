class Ride < ActiveRecord::Base
  belongs_to :driver
  has_and_belongs_to_many :riders
  scope :available_to_pool, -> { where(available_to_pool: true) }
  acts_as_mappable
  
  def car
    driver.car
  end
  
  def available_to_pool!
    if passengers < car.seats
      update_attributes available_to_pool: true
    else
      update_attributes available_to_pool: false
    end
  end
  
  def update_location
    self.lat = car.lat
    self.lng = car.lng
    self.save!
  end


  def add_passengers(new_rider, new_passengers)
    
    if passengers + new_passengers <= car.seats
      # can fit into car
      self.passengers += new_passengers
      self.riders << new_rider
      self.available_to_pool!
      self.save!
    else
      false
    end
    
  end
end
