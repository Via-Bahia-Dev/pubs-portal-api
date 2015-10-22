require 'rails_helper'

RSpec.describe PublicationRequestsController, type: :routing do
  it { expect(get:    "/publication_requests").to   route_to("publication_requests#index") }
  it { expect(get:    "/publication_requests/1").to route_to("publication_requests#show", id: "1") }
  it { expect(post:   "/publication_requests").to   route_to("publication_requests#create") }
  it { expect(put:    "/publication_requests/1").to route_to("publication_requests#update", id: "1") }
  it { expect(delete: "/publication_requests/1").to route_to("publication_requests#destroy", id: "1") }
end