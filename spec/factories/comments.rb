FactoryGirl.define do
  factory :comment do
    association :user
    body "This should appear in the comments section and should wrap appropriately"
    commentable_type "Site"
    commentable_id 1
    parent_id 1
  end
end
