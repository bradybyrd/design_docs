FactoryGirl.define do
  factory :basin do
    sequence(:name) {|n| "Tank_#{n}"}
    depth 5
    width 15
    length 20
    diameter 15
    volume 705
    surface_area 124
    basin_type "rectangular"
    association :zone
  end
end
