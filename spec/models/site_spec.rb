require 'rails_helper'

RSpec.describe Site, type: :model do
  before(:each) do
    @customer = create(:customer)
    @site = create(:site_with_properties_and_values, customer_id: @customer.id)
  end
  
  describe 'model integrity' do
    before(:each) do
    end
    
    it 'should be a valid site' do
      expect(@site).to be_valid
    end
    
    it 'should respond to customer' do
      expect(@site.customer).to eq(@customer)
    end
    it 'should have properties and values' do
      expect(@site.properties).to exist
    end
    
  end
  
end
