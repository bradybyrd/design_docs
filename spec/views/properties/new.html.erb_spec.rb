require 'rails_helper'

RSpec.describe "properties/new", type: :view do
  before(:each) do
    assign(:property, Property.new(
      :name => "",
      :description => "MyText",
      :holder_model => "MyString",
      :holder_id => 1,
      :created_by_id => 1
    ))
  end

  it "renders new property form" do
    render

    assert_select "form[action=?][method=?]", properties_path, "post" do

      assert_select "input#property_name[name=?]", "property[name]"

      assert_select "textarea#property_description[name=?]", "property[description]"

      assert_select "input#property_holder_model[name=?]", "property[holder_model]"

      assert_select "input#property_holder_id[name=?]", "property[holder_id]"

      assert_select "input#property_created_by_id[name=?]", "property[created_by_id]"
    end
  end
end
