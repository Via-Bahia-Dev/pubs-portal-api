require "rails_helper"
require "cancan/matchers"

RSpec.describe Ability, type: :model do
	describe "User" do
		describe "abilities" do
			subject(:ability) { Ability.new(user) }
			let(:user) { User.create(email: "user@email.com", password: "asdfasdf", first_name: "user", last_name: "test") }
			let(:pr) { PublicationRequest.create(event: "Test Event 2015",
				description: "Awesome test event this weekend.",
				rough_date: "Mon, 17 Dec 2015 00:00:00 +0000",
				due_date: "Mon, 17 Dec 2015 00:00:00 +0000",
				event_date: "Mon, 17 Dec 2015 00:00:00 +0000" ,
				dimensions: "quarter",
				user_id: user.id) 
			}

			let(:attachment) {
				RequestAttachment.create(publication_request_id: pr.id, 
					file: File.new(Rails.root + 'app/assets/images/test-image.jpg'),
					user_id: user.id )
			}

			context "when is an admin" do
				

				it "can manage Users" do
					user.roles = [:admin, :user]
					should be_able_to(:manage, User)
				end
			end

			context "when is a user" do
				it { should be_able_to(:destroy, :session) }

				# User
				it { should_not be_able_to(:create, User) }
				it { should_not be_able_to(:index, User) }
				it { should be_able_to(:show, user) }
				it { should_not be_able_to(:update, User.new) }
				it { should be_able_to(:update, user)}
				it { should_not be_able_to(:delete, User) }

				# Request Attachment
				it { should be_able_to(:read, RequestAttachment) }
				it { should be_able_to(:create, RequestAttachment) }
				it { should be_able_to(:update, attachment) }
				it { should_not be_able_to(:update, RequestAttachment.new) }
				it { should be_able_to(:destroy, attachment) }
				it { should_not be_able_to(:destroy, RequestAttachment.new) }
			end

			context "when is anonymous" do
				let(:user) { nil }
				it { should be_able_to(:create, :session) }
				it { should_not be_able_to(:create, User) }
				it { should_not be_able_to(:read, User) }
				it { should_not be_able_to(:update, User) }
				it { should_not be_able_to(:delete, User) }
			end
		end
	end
end