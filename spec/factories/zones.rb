FactoryGirl.define do
  factory :zone do
    sequence(:name) { |n| "Zone#{n}"}
    description "MyText"
    updated_by_id 1
    association :site
  end
end
