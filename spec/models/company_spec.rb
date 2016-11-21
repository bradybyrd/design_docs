require 'rails_helper'

RSpec.describe Company, type: :model do
  before(:each) do
    @basin_count = 3
    @company = create(:company_with_all_related_objects, basin_count: @basin_count)
    
  end
  
  describe 'model integrity' do
    
    it 'should be a valid Company' do
      expect(@company).to be_valid
    end
    
    it 'should have child zones, sites and basins' do
      expect(@company.sites).to exist
      expect(@company.sites.first.zones).to exist
      expect(@company.sites.first.basins.size).to eq(@basin_count)
    end    
  end
end