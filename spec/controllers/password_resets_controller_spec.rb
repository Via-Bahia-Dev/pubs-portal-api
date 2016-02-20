require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  before do
    user = User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test")
    user_with_token = User.create(email: "token@email.com", password: "af3714ff0ffae", first_name: "token", last_name: "test", password_reset_token: "abcdef0123456", password_reset_sent_at: Time.zone.now )
    user_with_expired_token = User.create(email: "token2@email.com", password: "af3714ff0ffae", first_name: "token2", last_name: "test", password_reset_token: "abcdef0123456789", password_reset_sent_at: 3.hours.ago )
  end

  let(:user) { User.find_by_email("user@email.com") }
  let(:user_with_token) { User.find_by_email("token@email.com") }
  let(:user_with_expired_token) { User.find_by_email("token2@email.com") }

  let(:valid_email) { "user@email.com" }
  let(:invalid_email) { "blah@blah" }

  let(:valid_token) { "abcdef0123456" }
  let(:invalid_token) { "asdfasdfasdf" }

  let(:valid_password) { "asdfasdf" }
  let(:invalid_password) { "asdf" }

  describe "POST #create" do
    context "with valid email" do
      before do
        post :create, { email: valid_email, format: :json }
      end
      it "should assign the user" do
        expect(assigns(:user)).to eq(user)
      end

      it "should send an email" do
        expect {
          post :create, { email: valid_email }, format: :json
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "should respond with 204" do
        expect(response.response_code).to eq(204)
      end
    end

    context "with invalid email" do
      before do
        post :create, { email: invalid_email, format: :json }
      end

      it "should not assign the user" do
        expect(assigns(:user)).to be_nil
      end

      it "should not send an email" do
        expect {
          post :create, { email: invalid_email }, format: :json
        }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end

      it "should still respond with 204" do
        expect(response.response_code).to eq(204)
      end
    end
  end

  describe "PUT #update" do
    context "with valid token and valid password" do
      before do
        put :update, { id: valid_token, user: { password: valid_password, password_confirmation: valid_password }, format: :json  }
      end
      it "should assign the user" do
        expect(assigns(:user)).to eq(user_with_token)
      end
      # Not sure how to test password being changed
      # it "should update the password" do
      #   expect(user.password).to eq(valid_password)
      # end
      it "should respond with 204" do
        expect(response.response_code).to eq(204)
      end
    end

    context "with valid token but invalid password" do
      before do
        put :update, { id: valid_token, user: { password: invalid_password, password_confirmation: invalid_password }, format: :json  }
      end
      it "should assign the user" do
        expect(assigns(:user)).to eq(user_with_token)
      end
      it { expect(response.status).to eq(422) }
      it { expect(response.body).to match(/error/) }
    end

    context "with valid token but missing password confirmation" do
      before do
        put :update, { id: valid_token, user: { password: valid_password, password_confirmation: "" }, format: :json  }
      end
      it "should assign the user" do
        expect(assigns(:user)).to eq(user_with_token)
      end
      it { expect(response.status).to eq(422) }
      it { expect(response.body).to match(/error/) }
    end

    context "with valid token but made too long ago" do
      before do
        put :update, { id: "abcdef0123456789", user: { password: valid_password, password_confirmation: valid_password }, format: :json  }
      end
      it "should assign the user" do
        expect(assigns(:user)).to eq(user_with_expired_token)
      end
      it { expect(response.status).to eq(422) }
      it { expect(response.body).to match(/error/) }
      it { expect(response.body).to match(/expired/) }
    end

    context "with invalid token" do
      before do
        put :update, { id: invalid_token, user: { password: valid_password, password_confirmation: valid_password }, format: :json  }
      end
      it "should not assign the user" do
        expect(assigns(:user)).to be_nil
      end
      it { expect(response.status).to eq(404) }
    end
  end
end
