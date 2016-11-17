FactoryGirl.define do
  factory :company do
    sequence(:name) {|n| "City of Wastewater_#{n}" }
    description "MyText"
    
    factory :company_with_all_the_trimmings do
      transient do 
        basin_count = 2
        site_name = "#{name} Site1"
        user_email = "johnq.public@megacorp.com"
      end
      
      after(:create) do |company, evaluator|
        user = create(:user, company: company, email: evaluator.user_email)
        site = create(:site, company: company, name: evaluator.site_name)
        zone = create(:zone, site: site)
        create_list(:basin, evaluator.basin_count, zone: zone)
        create_list(:comment, 10, user: user, commentable_type: "Site", commentable_id: site.id)
      end
    end
  end
end
