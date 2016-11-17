FactoryGirl.define do
  factory :property_value do
    association :property
    holder_id 1
    sequence(:data) { |n| "Data #{n}" }
    
    factory :property_value_numeric do
      sequence(:data) { |n| n + 100 }
    end
  end
  
  
end

