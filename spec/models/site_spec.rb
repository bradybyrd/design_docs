require 'rails_helper'

RSpec.describe Site, type: :model do
  before(:each) do
    @company = create(:company)
    @site = create(:site_with_properties_and_values, company_id: @company.id)
  end
  
  describe 'model integrity' do
    before(:each) do
    end
    
    it 'should be a valid site' do
      expect(@site).to be_valid
    end
    
    it 'should respond to company' do
      expect(@site.company).to eq(@company)
    end
    it 'should have properties and values' do
      expect(@site.properties).to exist
    end
    
  end
  
end
