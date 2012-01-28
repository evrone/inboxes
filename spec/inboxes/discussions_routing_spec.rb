require "spec_helper"

describe Inboxes::DiscussionsController do
  describe "routing" do

    it "routes to #index" do
      get("/discussions").should route_to("inboxes/discussions#index")
    end

    it "routes to #new" do
      get("/discussions/new").should route_to("inboxes/discussions#new")
    end

    it "routes to #show" do
      get("/discussions/1").should route_to("inboxes/discussions#show", :id => "1")
    end

    it "routes to #create" do
      post("/discussions").should route_to("inboxes/discussions#create")
    end

  end
end
