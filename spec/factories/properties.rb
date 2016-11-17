FactoryGirl.define do
  factory :property do
    name "SampleProperty"
    description "MyText"
    holder_model "Site"
    category "Climate"
    created_by_id 1
    created_at "2016-09-23 11:17:49"
  
  end
end
