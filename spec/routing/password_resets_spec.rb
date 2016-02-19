require 'rails_helper'

RSpec.describe PasswordResetsController, type: :routing do
  it { expect(post:    "/password_resets").to   route_to("password_resets#create") }
  let(:token){ SecureRandom.urlsafe_base64 }
  it { expect(put:     "/password_resets/#{token}").to route_to("password_resets#update", id: "#{token}") }
end
