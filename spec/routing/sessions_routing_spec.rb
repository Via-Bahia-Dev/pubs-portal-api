require 'rails_helper'

RSpec.describe SessionsController, type: :routing do
	it { expect(post: "/sign_in").to route_to("sessions#create") }
	it { expect(delete: "/sign_out").to route_to("sessions#destroy") }
end