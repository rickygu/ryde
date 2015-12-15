require 'rails_helper'

RSpec.describe Driver, type: :model do
  it "has one car" do
    driver = create :driver
    expect(driver.car).to eq nil
    car = create :car, driver: driver
    expect(driver.car).to eq car
  end
end
