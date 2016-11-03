require 'rails_helper'

RSpec.describe "basins/edit", type: :view do
  before(:each) do
    @basin = assign(:basin, Basin.create!(
      :site_id => 1,
      :name => "MyString",
      :depth => "",
      :width => "",
      :length => "",
      :diameter => "",
      :volume => "",
      :surface_area => "",
      :side_slope_ratio => ""
    ))
  end

  it "renders the edit basin form" do
    render

    assert_select "form[action=?][method=?]", basin_path(@basin), "post" do

      assert_select "input#basin_site_id[name=?]", "basin[site_id]"

      assert_select "input#basin_name[name=?]", "basin[name]"

      assert_select "input#basin_depth[name=?]", "basin[depth]"

      assert_select "input#basin_width[name=?]", "basin[width]"

      assert_select "input#basin_length[name=?]", "basin[length]"

      assert_select "input#basin_diameter[name=?]", "basin[diameter]"

      assert_select "input#basin_volume[name=?]", "basin[volume]"

      assert_select "input#basin_surface_area[name=?]", "basin[surface_area]"

      assert_select "input#basin_side_slope_ratio[name=?]", "basin[side_slope_ratio]"
    end
  end
end
