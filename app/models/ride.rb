class Ride < ActiveRecord::Base
  belongs_to :driver
  has_and_belongs_to_many :riders
  
end
