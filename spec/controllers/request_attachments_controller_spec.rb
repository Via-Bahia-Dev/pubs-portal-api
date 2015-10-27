require 'rails_helper'

RSpec.describe RequestAttachmentsController, type: :controller do

  before do
    user = User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
    user.add_roles([:admin])
    authentication_token = AuthenticationToken.create(user_id: user.id, body: "token", last_used_at: DateTime.current)
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
  end

  it_behaves_like "api_controller"
  it_behaves_like "authenticated_api_controller"

  let(:user) { User.create(email: "user2@email.com", password: "af3714ff0ffae", first_name: "user2", last_name: "test") }

  let(:pr) { PublicationRequest.create(event: "Test Event 2015",
                                       description: "Awesome test event this weekend.",
                                       rough_date: "Mon, 17 Dec 2015 00:00:00 +0000",
                                       due_date: "Mon, 17 Dec 2015 00:00:00 +0000",
                                       event_date: "Mon, 17 Dec 2015 00:00:00 +0000",
                                       dimensions: "quarter",
                                       user_id: 1,
                                       admin_id: 2,
                                       designer_id: 3,
                                       reviewer_id: 4,
                                       status: "unassigned" )
             }

  let(:valid_attributes) {
    { publication_request_id: pr.id, file: File.new(Rails.root + 'app/assets/images/test-image.jpg'), user_id: user.id }
  }

  let(:invalid_attributes) {
    { publication_request_id: pr.id, file: nil, user_id: user.id }
  }

  let!(:request_attachment) { RequestAttachment.create(valid_attributes) }

  describe "GET #index" do
    it "assigns all request_attachments as @request_attachments" do
      get :index, { format: :json }
      expect(assigns(:request_attachments)).to eq([request_attachment])
    end
  end

  describe "GET #show" do
    it "assigns the request_attachment as @request_attachment" do
      get :show, { id: request_attachment.id, format: :json }
      expect(assigns(:request_attachment)).to eq(request_attachment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new RequestAttachment" do
        expect {
          post :create, { request_attachment: valid_attributes, format: :json  }
        }.to change(RequestAttachment, :count).by(1)
      end

      it "assigns a newly created attachment as @request_attachment" do
        post :create, { request_attachment: valid_attributes, format: :json  }
        expect(assigns(:request_attachment)).to be_a(RequestAttachment)
        expect(assigns(:request_attachment)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved request_attachment as @request_attachment" do
        post :create, { request_attachment: invalid_attributes, format: :json  }
        expect(assigns(:request_attachment)).to be_a(RequestAttachment)
      end

      it "returns unprocessable_entity status" do
        put :create, { request_attachment: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { comment: "This is an attachment" }
      }

      it "updates the requested request_attachment" do
        put :update, { id: request_attachment.id, request_attachment: new_attributes, format: :json  }
        request_attachment.reload
        expect(request_attachment.comment).to eq("This is an attachment")
      end

      it "assigns the requested request_attachment as @request_attachment" do
        put :update, { id: request_attachment.id, request_attachment: valid_attributes, format: :json  }
        expect(assigns(:request_attachment)).to eq(request_attachment)
      end
    end

    context "with invalid params" do
      it "assigns the request_attachment as @request_attachment" do
        put :update, { id: request_attachment.id, request_attachment: invalid_attributes, format: :json  }
        expect(assigns(:request_attachment)).to eq(request_attachment)
      end

      it "returns unprocessable_entity status" do
        put :update, { id: request_attachment.id, request_attachment: invalid_attributes, format: :json }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested request_attachment" do
      expect {
        delete :destroy, { id: request_attachment.id, format: :json  }
      }.to change(RequestAttachment, :count).by(-1)
    end

    it "redirects to the publication requests list" do
      delete :destroy, { id: request_attachment.id, format: :json  }
      expect(response.status).to eq(204)
    end
  end
end
