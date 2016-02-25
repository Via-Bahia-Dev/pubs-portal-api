require 'rails_helper'

RSpec.describe StatusesController, type: :controller do

  before do
    user = User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
    user.add_roles([:admin])
    authentication_token = AuthenticationToken.create(user_id: user.id, body: "token", last_used_at: DateTime.current)
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
  end

  it_behaves_like "api_controller"
  it_behaves_like "authenticated_api_controller"

  let(:valid_attributes) {
    { name: "Status 1", color: 0, order: 1 }
  }

  let(:invalid_attributes) {
    { name: nil, color: 0, order: 1 }
  }

  let!(:status) { Status.create(valid_attributes) }

  describe "GET #index" do
    it "should assign all statuses as @statuses" do
      get :index, { format: :json }
      expect(assigns(:statuses)).to eq([status])
    end
  end

  describe "GET #show" do
    it "should assaign the requested status to @status" do
      get :show, { id: status.id, format: :json }
      expect(assigns(:status)).to eq(status)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "should create a new Status" do
        expect {
          post :create, { status: valid_attributes, format: :json  }
        }.to change(Status, :count).by(1)
      end

      it "should assign a newly created status as @status" do
        post :create, { status: valid_attributes, format: :json  }
        expect(assigns(:status)).to be_a(Status)
        expect(assigns(:status)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved status as @status" do
        post :create, { status: invalid_attributes, format: :json  }
        expect(assigns(:status)).to be_a_new(Status)
      end

      it "returns unprocessable_entity status" do
        put :create, { status: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { color: 100}
      }

      it "updates the requested status" do
        put :update, { id: status.id, status: new_attributes, format: :json  }
        status.reload
        expect(status.color).to eq(100)
      end

      it "assigns the requested status as @status" do
        put :update, { id: status.id, status: valid_attributes, format: :json  }
        expect(assigns(:status)).to eq(status)
        expect(assigns(:status)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns the status as @status" do
        put :update, { id: status.id, status: invalid_attributes, format: :json  }
        expect(assigns(:status)).to eq(status)
      end

      it "returns unprocessable_entity status" do
        put :update, { id: status.id, status: invalid_attributes, format: :json }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested status" do
      expect {
        delete :destroy, { id: status.id, format: :json  }
      }.to change(Status, :count).by(-1)
    end

    it "redirects to the statuses list" do
      delete :destroy, { id: status.id, format: :json  }
      expect(response.status).to eq(204)
    end
  end

end
