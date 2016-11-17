FactoryGirl.define do
  factory :zone do
    sequence(:name) { |n| "Zone#{n}"}
    description "MyText"
    archived_at "2016-11-02 10:43:09"
    archive_number "MyString"
    updated_by_id 1
    association :site
  end
end
