require 'rails_helper'

# This is for resources that are nested in publication request so they need a publication_request
# specific route for #create

RSpec.shared_examples "publication_request_api_controller" do

  describe "rescues from ActiveRecord::RecordNotFound" do

    context "on GET #show" do
      before { get :show, { id: 'not-existing', format: :json } }

      it { expect(response.status).to eq(404) }
      it { expect(response.body).to be_blank }
    end

    context "on PUT #update" do
      before { put :update, { id: 'not-existing', format: :json } }

      it { expect(response.status).to eq(404) }
      it { expect(response.body).to be_blank }
    end

    context "on DELETE #destroy" do
      before { delete :destroy, { id: 'not-existing', format: :json } }

      it { expect(response.status).to eq(404) }
      it { expect(response.body).to be_blank }
    end

  end

  describe "rescues from ActionController::ParameterMissing" do

    context "on POST #create" do
      before { post :create, { publication_request_id: 1, wrong_params: { foo: :bar }, format: :json } }

      it { expect(response.status).to eq(422) }
      it { expect(response.body).to match(/error/) }
    end

  end

  # These specs don't work for some reason. No headers
  # describe "responds to OPTIONS requests to return CORS headers" do

  #   before { process :index, 'OPTIONS' }

  #   context "CORS requests" do
  #     it "returns the Access-Control-Allow-Origin header to allow CORS from anywhere" do
  #       puts response.headers
  #       expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
  #     end

  #     it "returns general HTTP methods through CORS (GET/POST/PUT/DELETE)" do
  #       %w{GET POST PUT DELETE}.each do |method|
  #         expect(response.headers['Access-Control-Allow-Methods']).to include(method)
  #       end
  #     end

  #     it "returns the allowed headers" do
  #       %w{Content-Type Accept X-User-Email X-Auth-Token}.each do |header|
  #         expect(response.headers['Access-Control-Allow-Headers']).to include(header)
  #       end
  #     end
  #   end

  # end
  


end