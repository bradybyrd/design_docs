FactoryGirl.define do
  factory :property_value do
    association :property
    property_id 1
    holder_id 1
    sequence(:data) { |n| "Data #{n}" }
  end
end

