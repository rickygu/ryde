class Car < ActiveRecord::Base
  belongs_to :driver
  acts_as_mappable
  
  scope :available, -> { where(available: true) }
  
  def not_available!
    update_attributes available: false
  end
  
  def available!
    update_attributes available: true
  end
end
