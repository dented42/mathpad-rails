require "rails_helper"

RSpec.describe ScratchpadsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/scratchpads").to route_to("scratchpads#index")
    end

    it "routes to #new" do
      expect(:get => "/scratchpads/new").to route_to("scratchpads#new")
    end

    it "routes to #show" do
      expect(:get => "/scratchpads/1").to route_to("scratchpads#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scratchpads/1/edit").to route_to("scratchpads#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/scratchpads").to route_to("scratchpads#create")
    end

    it "routes to #update" do
      expect(:put => "/scratchpads/1").to route_to("scratchpads#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scratchpads/1").to route_to("scratchpads#destroy", :id => "1")
    end

  end
end
