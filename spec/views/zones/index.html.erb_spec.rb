require 'rails_helper'

RSpec.describe "zones/index", type: :view do
  before(:each) do
    assign(:zones, [
      Zone.create!(
        :name => "Name",
        :description => "MyText",
        :archive_number => "Archive Number",
        :updated_by_id => 2,
        :site_id => 3
      ),
      Zone.create!(
        :name => "Name",
        :description => "MyText",
        :archive_number => "Archive Number",
        :updated_by_id => 2,
        :site_id => 3
      )
    ])
  end

  it "renders a list of zones" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Archive Number".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
