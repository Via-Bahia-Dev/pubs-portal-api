require 'rails_helper'

RSpec.describe StatusesController, type: :routing do
  it { expect(get:    "/statuses").to   route_to("statuses#index") }
  it { expect(get:    "/statuses/1").to route_to("statuses#show", id: "1") }
  it { expect(post:   "/statuses").to   route_to("statuses#create") }
  it { expect(put:    "/statuses/1").to route_to("statuses#update", id: "1") }
  it { expect(delete: "/statuses/1").to route_to("statuses#destroy", id: "1") }
end
