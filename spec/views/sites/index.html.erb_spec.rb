require 'rails_helper'

RSpec.describe "sites/index", type: :view do
  before(:each) do
    assign(:sites, [
      Site.create!(
        :customer_id => 2,
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :phone => "Phone",
        :gps => "Gps"
      ),
      Site.create!(
        :customer_id => 2,
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :phone => "Phone",
        :gps => "Gps"
      )
    ])
  end

  it "renders a list of sites" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Address1".to_s, :count => 2
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Gps".to_s, :count => 2
  end
end
