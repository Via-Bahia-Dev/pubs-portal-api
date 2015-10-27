require 'rails_helper'

RSpec.describe TemplatesController, type: :routing do
  it { expect(get:    "/templates").to   route_to("templates#index") }
  it { expect(get:    "/templates/1").to route_to("templates#show", id: "1") }
  it { expect(post:   "/templates").to   route_to("templates#create") }
  it { expect(put:    "/templates/1").to route_to("templates#update", id: "1") }
  it { expect(delete: "/templates/1").to route_to("templates#destroy", id: "1") }
end