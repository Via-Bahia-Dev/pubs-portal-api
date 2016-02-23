require 'rails_helper'

RSpec.describe PublicationRequestsController, type: :controller do

  before do
    user = User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
    user.add_roles([:admin])
    authentication_token = AuthenticationToken.create(user_id: user.id, body: "token", last_used_at: DateTime.current)
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
  end

  it_behaves_like "api_controller"
  it_behaves_like "authenticated_api_controller"

  let(:user) { User.first }

  let(:status) {
    Status.create(name: "Status 1", color: 0, order: 1)
  }

  let(:valid_attributes) {
    { event: "Test Event 2015", description: "Awesome test event this weekend.",  rough_date: "Mon, 17 Dec 2015 00:00:00 +0000", due_date: "Mon, 17 Dec 2015 00:00:00 +0000", event_date: "Mon, 17 Dec 2015 00:00:00 +0000", dimensions: "quarter", user_id: 1, admin_id: 2, designer_id: user.id, reviewer_id: user.id, status_id: status.id }
  }

  let(:invalid_attributes) {
    { event: nil, description: "Awesome test event this weekend.",  rough_date: "Mon, 17 Dec 2015 00:00:00 +0000", due_date: "Mon, 17 Dec 2015 00:00:00 +0000", event_date: "Mon, 17 Dec 2015 00:00:00 +0000", dimensions: "quarter", user_id: 1, admin_id: 2, designer_id: user.id, reviewer_id: user.id, status_id: status.id }
  }

  let!(:publication_request) { PublicationRequest.create(valid_attributes) }

  describe "GET #show" do
    it "assigns the publication_request as @publication_request" do
      get :show, { id: publication_request.id, format: :json }
      expect(assigns(:publication_request)).to eq(publication_request)
    end
  end

  describe "GET #index" do
    it "assigns all publication_requests as @publication_requests" do
      get :index, { format: :json }
      expect(assigns(:publication_requests)).to eq([publication_request])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PublicationRequest" do
        expect {
          post :create, { publication_request: valid_attributes, format: :json  }
        }.to change(PublicationRequest, :count).by(1)
      end

      it "assigns a newly created request as @publication_request" do
        post :create, { publication_request: valid_attributes, format: :json  }
        expect(assigns(:publication_request)).to be_a(PublicationRequest)
        expect(assigns(:publication_request)).to be_persisted
      end

      it "should send 2 emails" do
        expect {
          post :create, { publication_request: valid_attributes, format: :json  }
        }.to change { ActionMailer::Base.deliveries.count }.by(2)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved publication_request as @publication_request" do
        post :create, { publication_request: invalid_attributes, format: :json  }
        expect(assigns(:publication_request)).to be_a(PublicationRequest)
      end

      it "returns unprocessable_entity status" do
        put :create, { publication_request: invalid_attributes }
        expect(response.status).to eq(422)
      end

      it "should not send any emails" do
        expect {
          post :create, { publication_request: invalid_attributes, format: :json  }
        }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { event: "newName", dimensions: "half sheet", description: "new description"}
      }

      it "updates the requested publication_request" do
        put :update, { id: publication_request.id, publication_request: new_attributes, format: :json  }
        publication_request.reload
        expect(publication_request.event).to eq("newName")
        expect(publication_request.dimensions).to eq("half sheet")
        expect(publication_request.description).to eq("new description")
      end

      it "assigns the requested publication_request as @publication_request" do
        put :update, { id: publication_request.id, publication_request: valid_attributes, format: :json  }
        expect(assigns(:publication_request)).to eq(publication_request)
      end
    end

    context "with invalid params" do
      it "assigns the publication_request as @publication_request" do
        put :update, { id: publication_request.id, publication_request: invalid_attributes, format: :json  }
        expect(assigns(:publication_request)).to eq(publication_request)
      end

      it "returns unprocessable_entity status" do
        put :update, { id: publication_request.id, publication_request: invalid_attributes, format: :json }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested publication_request" do
      expect {
        delete :destroy, { id: publication_request.id, format: :json  }
      }.to change(PublicationRequest, :count).by(-1)
    end

    it "redirects to the publication requests list" do
      delete :destroy, { id: publication_request.id, format: :json  }
      expect(response.status).to eq(204)
    end
  end

end
