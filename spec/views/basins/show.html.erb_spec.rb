require 'rails_helper'

RSpec.describe "basins/show", type: :view do
  before(:each) do
    @basin = assign(:basin, Basin.create!(
      :site_id => 2,
      :name => "Name",
      :depth => "",
      :width => "",
      :length => "",
      :diameter => "",
      :volume => "",
      :surface_area => "",
      :side_slope_ratio => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
