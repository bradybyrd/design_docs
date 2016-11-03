require 'rails_helper'

RSpec.describe "zones/new", type: :view do
  before(:each) do
    assign(:zone, Zone.new(
      :name => "MyString",
      :description => "MyText",
      :archive_number => "MyString",
      :updated_by_id => 1,
      :site_id => 1
    ))
  end

  it "renders new zone form" do
    render

    assert_select "form[action=?][method=?]", zones_path, "post" do

      assert_select "input#zone_name[name=?]", "zone[name]"

      assert_select "textarea#zone_description[name=?]", "zone[description]"

      assert_select "input#zone_archive_number[name=?]", "zone[archive_number]"

      assert_select "input#zone_updated_by_id[name=?]", "zone[updated_by_id]"

      assert_select "input#zone_site_id[name=?]", "zone[site_id]"
    end
  end
end
