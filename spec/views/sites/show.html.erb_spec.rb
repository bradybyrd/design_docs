require 'rails_helper'

RSpec.describe "sites/show", type: :view do
  before(:each) do
    @site = assign(:site, Site.create!(
      :company_id => 2,
      :address1 => "Address1",
      :address2 => "Address2",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :phone => "Phone",
      :gps => "Gps"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Address1/)
    expect(rendered).to match(/Address2/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Gps/)
  end
end
