require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "password_reset" do
    let(:user) { User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test", password_reset_token: "abcdef0123456") }
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Password Reset")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["publications.portal@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("http://localhost:3000/password_resets/abcdef0123456/edit")
    end
  end

end
