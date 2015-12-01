require 'rails_helper'

RSpec.describe TemplatesController, type: :controller do

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
    { name: "2015 NSWN Flyer", user_id: 1,  dimensions: "5x7", image: File.new(Rails.root + 'app/assets/images/test-image.jpg') }
  }

  let(:invalid_attributes) {
    { name: nil, user_id: 1,  dimensions: "5x7", image: nil }
  }

  let!(:template) { Template.create(valid_attributes) }

  describe "GET #show" do
    it "assigns the template as @template" do
      get :show, { id: template.id, format: :json }
      expect(assigns(:template)).to eq(template)
    end
  end

  describe "GET #index" do
    it "assigns all templates as @templates" do
      get :index, { format: :json }
      expect(assigns(:templates)).to eq([template])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Template" do
        expect {
          post :create, { template: valid_attributes, format: :json  }
        }.to change(Template, :count).by(1)
      end

      it "assigns a newly created template as @template" do
        post :create, { template: valid_attributes, format: :json  }
        expect(assigns(:template)).to be_a(Template)
        expect(assigns(:template)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved template as @template" do
        post :create, { template: invalid_attributes, format: :json  }
        expect(assigns(:template)).to be_a(Template)
      end

      it "returns unprocessable_entity status" do
        put :create, { template: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "newName", dimensions: "4x6" }
      }

      it "updates the requested template" do
        put :update, { id: template.id, template: new_attributes, format: :json  }
        template.reload
        expect(template.name).to eq("newName")
        expect(template.dimensions).to eq("4x6")
      end

      it "assigns the requested template as @template" do
        put :update, { id: template.id, template: valid_attributes, format: :json  }
        expect(assigns(:template)).to eq(template)
      end
    end

    context "with invalid params" do
      it "assigns the template as @template" do
        put :update, { id: template.id, template: invalid_attributes, format: :json  }
        expect(assigns(:template)).to eq(template)
      end

      it "returns unprocessable_entity status" do
        put :update, { id: template.id, template: invalid_attributes, format: :json }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested template" do
      expect {
        delete :destroy, { id: template.id, format: :json  }
      }.to change(Template, :count).by(-1)
    end

    it "redirects to the publication requests list" do
      delete :destroy, { id: template.id, format: :json  }
      expect(response.status).to eq(204)
    end
  end

end
