require 'rails_helper'

RSpec.describe RequestAttachmentsController, type: :routing do
  it { expect(get:    "/publication_requests/1/request_attachments").to route_to("request_attachments#index",  publication_request_id: "1") }
  it { expect(post:   "/publication_requests/1/request_attachments").to route_to("request_attachments#create", publication_request_id: "1") }
  it { expect(get:    "/request_attachments/1").to route_to("request_attachments#show",    id: "1") }
  it { expect(put:    "/request_attachments/1").to route_to("request_attachments#update",  id: "1") }
  it { expect(delete: "/request_attachments/1").to route_to("request_attachments#destroy", id: "1") }
end