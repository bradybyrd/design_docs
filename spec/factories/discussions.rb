FactoryGirl.define do
  factory :discussion do
    user_id 1
    body "MyText"
    holder_model "MyString"
    holder_id 1
    parent_id 1
  end
end
