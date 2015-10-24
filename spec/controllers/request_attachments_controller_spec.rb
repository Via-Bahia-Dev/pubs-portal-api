require 'rails_helper'

RSpec.describe RequestAttachmentsController, type: :controller do

	before do
    user = create(:user)
    user.add_roles([:admin])
    authentication_token = AuthenticationToken.create(user_id: user.id, body: "token", last_used_at: DateTime.current)
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body

    pr = create(:publication_request)
  end

	it_behaves_like "api_controller"
  it_behaves_like "authenticated_api_controller"

  let(:valid_attributes) {
    { publication_request_id: 1, file: File.new(Rails.root + 'app/assets/images/test-image.jpg') }
  }

  let(:invalid_attributes) {
    { publication_request_id: 1, file: nil}
  }

  let!(:requets_attachment) { RequestAttachment.create(valid_attributes) }

  describe "GET #show" do
    it "assigns the request_attachment as @request_attachment" do
      get :show, { id: request_attachment.id, format: :json }
      expect(assigns(:request_attachment)).to eq(request_attachment)
    end
  end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new PublicationRequest" do
  #       expect {
  #         post :create, { request_attachment: valid_attributes, format: :json  }
  #       }.to change(PublicationRequest, :count).by(1)
  #     end

  #     it "assigns a newly created user as @user" do
  #       post :create, { request_attachment: valid_attributes, format: :json  }
  #       expect(assigns(:request_attachment)).to be_a(PublicationRequest)
  #       expect(assigns(:request_attachment)).to be_persisted
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved request_attachment as @request_attachment" do
  #       post :create, { request_attachment: invalid_attributes, format: :json  }
  #       expect(assigns(:request_attachment)).to be_a(PublicationRequest)
  #     end

  #     it "returns unprocessable_entity status" do
  #       put :create, { request_attachment: invalid_attributes }
  #       expect(response.status).to eq(422)
  #     end
  #   end
  # end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       { event: "newName", dimensions: "half sheet", description: "new description"}
  #     }

  #     it "updates the requested request_attachment" do
  #       put :update, { id: request_attachment.id, request_attachment: new_attributes, format: :json  }
  #       request_attachment.reload
  #       expect(request_attachment.event).to eq("newName")
  #       expect(request_attachment.dimensions).to eq("half sheet")
  #       expect(request_attachment.description).to eq("new description")
  #     end

  #     it "assigns the requested request_attachment as @request_attachment" do
  #       put :update, { id: request_attachment.id, request_attachment: valid_attributes, format: :json  }
  #       expect(assigns(:request_attachment)).to eq(request_attachment)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns the request_attachment as @request_attachment" do
  #       put :update, { id: request_attachment.id, request_attachment: invalid_attributes, format: :json  }
  #       expect(assigns(:request_attachment)).to eq(request_attachment)
  #     end

  #     it "returns unprocessable_entity status" do
  #       put :update, { id: request_attachment.id, request_attachment: invalid_attributes, format: :json }
  #       expect(response.status).to eq(422)
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested request_attachment" do
  #     expect {
  #       delete :destroy, { id: request_attachment.id, format: :json  }
  #     }.to change(PublicationRequest, :count).by(-1)
  #   end

  #   it "redirects to the publication requests list" do
  #     delete :destroy, { id: request_attachment.id, format: :json  }
  #     expect(response.status).to eq(204)
  #   end
  # end
end
