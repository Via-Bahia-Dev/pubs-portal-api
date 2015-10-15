require 'rails_helper'

RSpec.shared_examples "authenticated_api_controller" do

	describe "authentication" do
		it "returns unauthorized request without email and token" do
			request.env["HTTP_X_USER_EMAIL"] = nil
			request.env["HTTP_X_AUTH_TOKEN"] = nil
			get :index, { format: :json }

			expect(response.status).to eq(401)
		end

		it "returns unauthorized request without token" do
			user = User.create( email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
			request.env["HTTP_X_USER_EMAIL"] = user.email
			request.env["HTTP_X_AUTH_TOKEN"] = nil
			get :index, { format: :json }

			expect(response.status).to eq(401)
		end
	end
end
