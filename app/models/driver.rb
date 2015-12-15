class Driver < ActiveRecord::Base
  has_one :car
  has_many :rides
  
end
