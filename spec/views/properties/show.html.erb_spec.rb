require 'rails_helper'

RSpec.describe "properties/show", type: :view do
  before(:each) do
    @property = assign(:property, Property.create!(
      :name => "",
      :description => "MyText",
      :holder_model => "Holder Model",
      :holder_id => 2,
      :created_by_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Holder Model/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
