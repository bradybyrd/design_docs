FactoryGirl.define do
  factory :company do
    sequence(:name) {|n| "City of Wastewater_#{n}" }
    description "MyText"
    
    factory :company_with_all_related_objects do
      transient do 
        basin_count 2
        site_name "Company Site1"
        user_email "johnq.public@megacorp.com"
      end
      
      after(:create) do |company, evaluator|
        user = create(:user, company: company, email: evaluator.user_email)
        site = create(:site_with_properties_and_values, company: company, name: evaluator.site_name)
        zone = create(:zone, site: site)
        create_list(:basin, evaluator.basin_count, zone: zone)
        prop3 = create(:property, name: 'Property for Zone no value', holder_model: 'Zone')
        prop4 = create(:property, name: 'Property for Zone with value', holder_model: 'Zone')
        pv = create(:property_value, property_id: prop4.id, holder_id: zone.id, data: "Zone1Data" )
        
        10.times do
          comment = Comment.build_from( site, user.id, "This should appear in the comments section and should wrap appropriately" )
          comment.save
        end
      end
    end
  end
end
