require 'rails_helper'

RSpec.describe Property, type: :model do
  before(:each) do
    @customer = create(:customer)
    @site = create(:site_with_properties_and_values, customer_id: @customer.id)
    @property = @site.properties.first
  end
  
  
  describe 'model integrity' do    
    it 'should be a valid property' do
      expect(@property).to be_valid
    end
  end
  
  describe 'property_value behavior' do
    before(:each) do
      @property_value = @property.property_values.first
      @property.property_values.create(holder_id: @site.id, data: "NewValue_#{Time.now.to_s}")
    end

    it 'should have only one current value per holder_id' do
      expect(@property.property_values.first).not_to eq(@property_value)
    end
    
    it 'should expire existing property values on save' do
      expect(@property_value.archive_number).not_to eq(nil)
    end
    
  end
end
