require 'rails_helper'

RSpec.describe "basins/index", type: :view do
  before(:each) do
    assign(:basins, [
      Basin.create!(
        :site_id => 2,
        :name => "Name",
        :depth => "",
        :width => "",
        :length => "",
        :diameter => "",
        :volume => "",
        :surface_area => "",
        :side_slope_ratio => ""
      ),
      Basin.create!(
        :site_id => 2,
        :name => "Name",
        :depth => "",
        :width => "",
        :length => "",
        :diameter => "",
        :volume => "",
        :surface_area => "",
        :side_slope_ratio => ""
      )
    ])
  end

  it "renders a list of basins" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
