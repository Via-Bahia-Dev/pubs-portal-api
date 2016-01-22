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
				it "can manage all models" do
					user.roles = [:admin, :user]
					should be_able_to(:manage, User)
					should be_able_to(:manage, PublicationRequest)
					should be_able_to(:manage, Comment)
					should be_able_to(:manage, RequestAttachment)
				end
			end

			context "when is a user" do
				it { should be_able_to(:destroy, :session) }

				# User
				it { should_not be_able_to(:create, User) }
				it { should_not be_able_to(:index, User) }
				it { should     be_able_to(:show, user) }
				it { should_not be_able_to(:update, User.new) }
				it { should     be_able_to(:update, user)}
				it { should_not be_able_to(:delete, User) }

				# Request Attachment
				it { should     be_able_to(:read, RequestAttachment) }
				it { should     be_able_to(:create, RequestAttachment) }
				it { should     be_able_to(:update, attachment) }
				it { should_not be_able_to(:update, RequestAttachment.new) }
				it { should     be_able_to(:destroy, attachment) }
				it { should_not be_able_to(:destroy, RequestAttachment.new) }

				# Comments
				it { should     be_able_to(:read, Comment) }
				it { should     be_able_to(:create, Comment) }
				it { should     be_able_to(:update, attachment) }
				it { should_not be_able_to(:update, Comment.new) }
				it { should     be_able_to(:destroy, attachment) }
				it { should_not be_able_to(:destroy, Comment.new) }

				# Templates
				it { should     be_able_to(:read, Template) }

				#Publication Requests
				it { should_not be_able_to(:read, PublicationRequest.new) }
				it { should     be_able_to(:read, PublicationRequest.new(user_id: user.id)) }
			end

			context "when is a designer" do
				it "can read requests that they are a designer for" do
					user.roles = [:designer, :user]
					should_not be_able_to(:read, PublicationRequest.new)
					should     be_able_to(:read, PublicationRequest.new(designer_id: user.id)) 
				end

				it "can design requests that they are a designer for" do
					user.roles = [:designer, :user]
					should_not be_able_to(:design, PublicationRequest.new)
					should     be_able_to(:design, PublicationRequest.new(designer_id: user.id)) 
				end
			end

			context "when is a reviewer" do
				it "can read requests that they are a reviewer for" do
					user.roles = [:reviewer, :user]
					should_not be_able_to(:read, PublicationRequest.new)
					should     be_able_to(:read, PublicationRequest.new(reviewer_id: user.id))
				end

				it "can read requests that they are a reviewer for" do
					user.roles = [:reviewer, :user]
					should_not be_able_to(:review, PublicationRequest.new)
					should     be_able_to(:review, PublicationRequest.new(reviewer_id: user.id))
				end
			end

			context "when is anonymous" do
				let(:user) { nil }
				it { should be_able_to(:create, :session) }
				it { should_not be_able_to(:create, User) }
				it { should_not be_able_to(:read,   User) }
				it { should_not be_able_to(:update, User) }
				it { should_not be_able_to(:delete, User) }

				it { should_not be_able_to(:create, PublicationRequest) }
				it { should_not be_able_to(:read,   PublicationRequest) }
				it { should_not be_able_to(:update, PublicationRequest) }
				it { should_not be_able_to(:delete, PublicationRequest) }
			end
		end
	end
end