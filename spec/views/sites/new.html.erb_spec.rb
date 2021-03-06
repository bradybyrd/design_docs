require 'rails_helper'

RSpec.describe "sites/new", type: :view do
  before(:each) do
    assign(:site, Site.new(
      :company_id => 1,
      :address1 => "MyString",
      :address2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :phone => "MyString",
      :gps => "MyString"
    ))
  end

  it "renders new site form" do
    render

    assert_select "form[action=?][method=?]", sites_path, "post" do

      assert_select "input#site_company_id[name=?]", "site[company_id]"

      assert_select "input#site_address1[name=?]", "site[address1]"

      assert_select "input#site_address2[name=?]", "site[address2]"

      assert_select "input#site_city[name=?]", "site[city]"

      assert_select "input#site_state[name=?]", "site[state]"

      assert_select "input#site_zip[name=?]", "site[zip]"

      assert_select "input#site_phone[name=?]", "site[phone]"

      assert_select "input#site_gps[name=?]", "site[gps]"
    end
  end
end
