require 'rails_helper'

RSpec.describe RequestAttachmentsController, type: :routing do
  it { expect(get:    "/request_attachments").to   route_to("request_attachments#index") }
  it { expect(get:    "/request_attachments/1").to route_to("request_attachments#show", id: "1") }
  it { expect(get:    "/request_attachments/1/edit").to route_to("request_attachments#edit", id: "1") }
  it { expect(post:   "/request_attachments").to   route_to("request_attachments#create") }
  it { expect(get:    "/request_attachments/new").to   route_to("request_attachments#new") }
  it { expect(put:    "/request_attachments/1").to route_to("request_attachments#update", id: "1") }
  it { expect(delete: "/request_attachments/1").to route_to("request_attachments#destroy", id: "1") }
end