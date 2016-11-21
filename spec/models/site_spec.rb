require 'rails_helper'

RSpec.describe Site, type: :model do
  before(:each) do
    @basin_count = 3
    @company = create(:company_with_all_related_objects, basin_count: @basin_count)
    @site = @company.sites.first
    
  end
  
  describe 'model integrity' do
    
    it 'should be a valid site' do
      expect(@site).to be_valid
    end
    
    it 'should respond to company' do
      expect(@site.company).to eq(@company)
    end
    it 'should have properties and values' do
      expect(@site.properties).to exist
    end
    
    it 'should give basins for all zones' do
      expect(@site.basins.count).to eq(@basin_count)
    end
    
  end
  
  describe 'displays correct data to api' do
  
    before(:each) do
      @api_data = @site.spreadsheet_data
      #puts "API_DATA\n#{@api_data.inspect}"
    end
    
    it "should have sections for each zone and basins" do
      expect(@api_data.select{|l| l[:holder] == "Zone"}.map{|k| k[:id]}.uniq.size).to eq(2)
      expect(@api_data.select{|l| l[:holder] == "Basin"}.map{|k| k[:id]}.uniq.size).to eq(@basin_count)
    end
    
    it "should show the properties both with and without values" do
      expect(@api_data.select{|l| l[:holder] == "Site" && l[:category] == "Climate" }.map{|k| k[:id]}.uniq.size).to eq(3)
    end
  end
  
end
