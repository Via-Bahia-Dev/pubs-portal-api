require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "publication request created emails" do
    let(:user) { User.create(email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test", password_reset_token: "abcdef0123456") }
    let(:pr) { PublicationRequest.create(event: "Test Event 2015", description: "Awesome test event this weekend.",  rough_date: "Mon, 17 Dec 2015 00:00:00 +0000", due_date: "Mon, 17 Dec 2015 00:00:00 +0000", event_date: "Mon, 17 Dec 2015 00:00:00 +0000", dimensions: "quarter", user_id: user.id, admin_id: user.id, designer_id: user.id, reviewer_id: user.id, status_id: 1)}
    let(:designer_mail) { PublicationRequestMailer.request_created_designer(pr) }
    let(:reviewer_mail) { PublicationRequestMailer.request_created_reviewer(pr) }

    context "for designer" do
      it { expect(designer_mail.subject).to eq("Publication Request for #{pr.event} assigned to you as designer")}
      it { expect(designer_mail.to).to eq([user.email]) }
      it { expect(designer_mail.from).to eq(["publications.portal@gmail.com"]) }

      it { expect(designer_mail.body.encoded).to match("A Publication Request for <strong>#{pr.event}</strong> has been created and you have been assigned as the <strong>designer</strong>")}
    end

    context "for reviewer" do
      it { expect(reviewer_mail.subject).to eq("Publication Request for #{pr.event} assigned to you as reviewer")}
      it { expect(reviewer_mail.to).to eq([user.email]) }
      it { expect(reviewer_mail.from).to eq(["publications.portal@gmail.com"]) }

      it { expect(reviewer_mail.body.encoded).to match("A Publication Request for <strong>#{pr.event}</strong> has been created and you have been assigned as the <strong>reviewer</strong>")}
    end


  end

end
