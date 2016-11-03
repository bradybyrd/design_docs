require 'rails_helper'

RSpec.describe "customers/index", type: :view do
  before(:each) do
    assign(:customers, [
      Customer.create!(
        :name => "",
        :description => "MyText"
      ),
      Customer.create!(
        :name => "",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of customers" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
