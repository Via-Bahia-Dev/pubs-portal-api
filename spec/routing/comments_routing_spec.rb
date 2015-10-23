require 'rails_helper'

RSpec.describe CommentsController, type: :routing do
  it { expect(get:    "/comments").to   route_to("comments#index") }
  it { expect(get:    "/comments/1").to route_to("comments#show", id: "1") }
  it { expect(post:   "/comments").to   route_to("comments#create") }
  it { expect(put:    "/comments/1").to route_to("comments#update", id: "1") }
  it { expect(delete: "/comments/1").to route_to("comments#destroy", id: "1") }
end