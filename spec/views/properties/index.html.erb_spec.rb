require 'rails_helper'

RSpec.describe "properties/index", type: :view do
  before(:each) do
    assign(:properties, [
      Property.create!(
        :name => "",
        :description => "MyText",
        :holder_model => "Holder Model",
        :holder_id => 2,
        :created_by_id => 3
      ),
      Property.create!(
        :name => "",
        :description => "MyText",
        :holder_model => "Holder Model",
        :holder_id => 2,
        :created_by_id => 3
      )
    ])
  end

  it "renders a list of properties" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Holder Model".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
