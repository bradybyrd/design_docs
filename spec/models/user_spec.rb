require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @basin_count = 1
    @company = create(:company_with_all_related_objects, basin_count: @basin_count)
    @user = @company.users.first
  end
  
  describe 'model integrity' do
    
    it 'should be a valid Company' do
      expect(@user).to be_valid
    end
  end
end