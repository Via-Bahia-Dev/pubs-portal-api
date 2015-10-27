require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

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
    { user_id: 1, content: "This is the best flyer ever.", date: "Mon, 17 Dec 2016 00:05:00 +0000", publication_request_id: 1 }
  }

  let(:invalid_attributes) {
    { user_id: nil, content: 45, date: "Mon, 17 Dec 2016 00:05:00 +0000", publication_request_id: 1 }
  }

  let!(:comment) { Comment.create(valid_attributes) }

  describe "GET #show" do
    it "assigns the comment as @comment" do
      get :show, { id: comment.id, format: :json }
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe "GET #index" do
    it "assigns all comments as @comments" do
      get :index, { format: :json }
      expect(assigns(:comments)).to eq([comment])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, { comment: valid_attributes, format: :json  }
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, { comment: valid_attributes, format: :json  }
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :create, { comment: invalid_attributes, format: :json  }
        expect(assigns(:comment)).to be_a(Comment)
      end

      it "returns unprocessable_entity status" do
        put :create, { comment: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { content: "Actually this is the worst flyer ever.", user_id: 1, publication_request_id: 1, date: "October 20, 2016"}
      }

      it "updates the requested comment" do
        put :update, { id: comment.id, comment: new_attributes, format: :json  }
        comment.reload
        expect(comment.content).to eq("Actually this is the worst flyer ever.")
        expect(comment.user_id).to eq(1)
        expect(comment.publication_request_id).to eq(1)
      end

      it "assigns the requested comment as @comment" do
        put :update, { id: comment.id, comment: valid_attributes, format: :json  }
        expect(assigns(:comment)).to eq(comment)
      end
    end

    context "with invalid params" do
      it "assigns the comment as @comment" do
        put :update, { id: comment.id, comment: invalid_attributes, format: :json  }
        expect(assigns(:comment)).to eq(comment)
      end

      it "returns unprocessable_entity status" do
        put :update, { id: comment.id, comment: invalid_attributes, format: :json }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      expect {
        delete :destroy, { id: comment.id, format: :json  }
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      delete :destroy, { id: comment.id, format: :json  }
      expect(response.status).to eq(204)
    end
  end

end
