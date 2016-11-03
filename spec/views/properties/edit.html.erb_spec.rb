require 'rails_helper'

RSpec.describe "properties/edit", type: :view do
  before(:each) do
    @property = assign(:property, Property.create!(
      :name => "",
      :description => "MyText",
      :holder_model => "MyString",
      :holder_id => 1,
      :created_by_id => 1
    ))
  end

  it "renders the edit property form" do
    render

    assert_select "form[action=?][method=?]", property_path(@property), "post" do

      assert_select "input#property_name[name=?]", "property[name]"

      assert_select "textarea#property_description[name=?]", "property[description]"

      assert_select "input#property_holder_model[name=?]", "property[holder_model]"

      assert_select "input#property_holder_id[name=?]", "property[holder_id]"

      assert_select "input#property_created_by_id[name=?]", "property[created_by_id]"
    end
  end
end
