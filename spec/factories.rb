FactoryGirl.define do
  factory :car do
    year "2010"
    brand  "Toyota"
    model "Prius"
    available true
    seats 4
    # randomly initalize some where in SF
    lat { 37.7833 +  (Random.rand(100) - 500.0 ) / 1000 }
    lng {-122.4167 +  (Random.rand(100) - 500.0 ) / 1000 }
    driver
  end
  
  factory :rider do
    sequence :name do |n|
      "rider#{n}"
    end
    lat { 37.7833 +  (Random.rand(100) - 500.0 ) / 1000 }
    lng {-122.4167 +  (Random.rand(100) - 500.0 ) / 1000 }    
  end
  
  factory :ride do
    
    trait :pool do
      pool true
    end
    
  end

  factory :driver do
    sequence :name do |n|
      "driver#{n}"
    end
  end
end