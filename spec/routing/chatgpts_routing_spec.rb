require "rails_helper"

RSpec.describe ChatgptsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/chatgpts").to route_to("chatgpts#index")
    end

    it "routes to #show" do
      expect(get: "/chatgpts/1").to route_to("chatgpts#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/chatgpts").to route_to("chatgpts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/chatgpts/1").to route_to("chatgpts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/chatgpts/1").to route_to("chatgpts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/chatgpts/1").to route_to("chatgpts#destroy", id: "1")
    end
  end
end
