require "rails_helper"

RSpec.describe ChatSessionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/chat_sessions").to route_to("chat_sessions#index")
    end

    it "routes to #show" do
      expect(get: "/chat_sessions/1").to route_to("chat_sessions#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/chat_sessions").to route_to("chat_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/chat_sessions/1").to route_to("chat_sessions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/chat_sessions/1").to route_to("chat_sessions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/chat_sessions/1").to route_to("chat_sessions#destroy", id: "1")
    end
  end
end
