require 'rails_helper'

RSpec.describe Basin, type: :model do
  before(:each) do
    @basin_count = 3
    @company = create(:company_with_all_related_objects, basin_count: @basin_count)
    @basin = @company.sites.first.basins.first
    
  end
  
  describe 'model integrity' do
    
    it 'should be a valid site' do
      expect(@basin).to be_valid
    end
    
    it 'should belong to a zone and site' do
      expect(@basin.zone).to be_present
      expect(@basin.zone.site).to be_present
    end    
  end
end
