require "rails_helper"

RSpec.describe BreedsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/breeds").to route_to("breeds#index")
    end


    it "routes to #show" do
      expect(:get => "/breeds/1").to route_to("breeds#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/breeds").to route_to("breeds#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/breeds/1").to route_to("breeds#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/breeds/1").to route_to("breeds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/breeds/1").to route_to("breeds#destroy", :id => "1")
    end

    it "routes to #stats" do
      expect(:get => "/breeds/stats").to route_to("breeds#stats")
    end

  end
end
