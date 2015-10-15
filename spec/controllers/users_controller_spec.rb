require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    user = User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
    authentication_token = AuthenticationToken.create(user_id: user.id, body: "token", last_used_at: DateTime.current)
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
  end


  it_behaves_like "api_controller"
  it_behaves_like "authenticated_api_controller"

  let(:valid_attributes) {
    { email: "test1@test.com", password: "asdfasdf",  first_name: "Test", last_name: "Name" }
  }

  let(:invalid_attributes) {
    { email: nil, password: "asdfasdf", first_name: "Test", last_name: "Name" }
  }

  let!(:user) { User.create(valid_attributes) }

  describe "GET #index" do
    it "assigns all users as @users" do
      get :index, { format: :json }
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      get :show, { id: user.id, format: :json }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, { user: valid_attributes, format: :json  }
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, { user: valid_attributes, format: :json  }
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, { user: invalid_attributes, format: :json  }
        expect(assigns(:user)).to be_a_new(User)
      end

      it "returns unprocessable_entity status" do
        put :create, { user: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { first_name: "newName"}
      }

      it "updates the requested user" do
        put :update, { id: user.id, user: new_attributes, format: :json  }
        user.reload
        expect(user.first_name).to eq("newName")
      end

      it "assigns the requested user as @user" do
        put :update, { id: user.id, user: valid_attributes, format: :json  }
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        put :update, { id: user.id, user: invalid_attributes, format: :json  }
        expect(assigns(:user)).to eq(user)
      end

      it "returns unprocessable_entity status" do
        put :update, { id: user.id, user: invalid_attributes, format: :json }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, { id: user.id, format: :json  }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, { id: user.id, format: :json  }
      expect(response.status).to eq(204)
    end
  end

end
