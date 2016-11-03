require 'rails_helper'

RSpec.describe "zones/show", type: :view do
  before(:each) do
    @zone = assign(:zone, Zone.create!(
      :name => "Name",
      :description => "MyText",
      :archive_number => "Archive Number",
      :updated_by_id => 2,
      :site_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Archive Number/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
