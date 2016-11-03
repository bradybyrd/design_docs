FactoryGirl.define do
  factory :site do
    customer_id 1
    name "Site Name with a lot of detail"
    address1 "22 Butterscotch Court"
    address2 "Suite 3700"
    city "Fairfax"
    state "VA"
    zip "22021"
    phone "703-978-3440"
    gps "38.830494 -77.232264"
    
    factory :site_with_properties_and_values do
      after(:create) do |site|
        site = create(:site)
        prop = create(:property, holder_model: "Site")
        prop1 = create(:property, name: 'Next Property Long Name', holder_model: 'Site')
        pv = create(:property_value, property_id: prop.id, holder_id: site.id )
        pv = create(:property_value, property_id: prop1.id, holder_id: site.id, data: "Site1Data" )
      end
    end
    
  end
end
