require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  it { expect(get:    "/users").to   route_to("users#index") }
  it { expect(get:    "/users/show/1").to route_to("users#show", id: "1") }
  it { expect(post:   "/users").to   route_to("users#create") }
  it { expect(put:    "/users/1").to route_to("users#update", id: "1") }
  it { expect(delete: "/users/1").to route_to("users#destroy", id: "1") }

  it { expect(get:    "/users/admins").to route_to("users#admins") }
  it { expect(get:    "/users/designers").to route_to("users#designers") }
  it { expect(get:    "/users/reviewers").to route_to("users#reviewers") }

  it { expect(put:    "/users/1/update_password").to route_to("users#update_password", id: "1") }
end
