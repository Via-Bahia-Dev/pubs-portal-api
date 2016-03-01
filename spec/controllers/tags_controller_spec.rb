require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  before do
    user = User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
    user.add_roles([:admin])
    authentication_token = AuthenticationToken.create(user_id: user.id, body: "token", last_used_at: DateTime.current)
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
  end

  # it_behaves_like "api_controller"
  # it_behaves_like "authenticated_api_controller"

  let(:valid_attributes) {
    { name: "tag" }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  let!(:tag) { Tag.create(valid_attributes) }

  describe "GET #index" do
    it "assigns all templates as @templates" do
      get :index, { format: :json }
      expect(assigns(:tags)).to eq([tag])
    end
  end
end
