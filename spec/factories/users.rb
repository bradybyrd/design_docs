FactoryGirl.define do
  factory :user do
    first_name "JohnQ"
    last_name "Public"
    sequence(:email) { |n| "#{first_name}.#{last_name}_#{n}@megacorp.com".downcase}
    password "kittens4me"
    password_confirmation "kittens4me"
    association :company
    
  end
end
