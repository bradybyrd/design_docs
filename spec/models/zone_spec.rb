require 'rails_helper'

RSpec.describe Zone, type: :model do
  before(:each) do
    @basin_count = 1
    @company = create(:company_with_all_related_objects, basin_count: @basin_count)
    @zone = @company.sites.first.zones.first
  end
  
  describe 'model integrity' do
    
    it 'should be a valid Company' do
      expect(@zone).to be_valid
    end
  end

  describe 'property behavior' do
    
    it 'should hold properties' do
      expect(@zone.properties.size).to eq(2)
    end
  end
end