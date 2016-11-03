require "rails_helper"

RSpec.describe BasinsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/basins").to route_to("basins#index")
    end

    it "routes to #new" do
      expect(:get => "/basins/new").to route_to("basins#new")
    end

    it "routes to #show" do
      expect(:get => "/basins/1").to route_to("basins#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/basins/1/edit").to route_to("basins#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/basins").to route_to("basins#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/basins/1").to route_to("basins#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/basins/1").to route_to("basins#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/basins/1").to route_to("basins#destroy", :id => "1")
    end

  end
end
