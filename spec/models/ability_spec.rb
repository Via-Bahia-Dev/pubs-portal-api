require "rails_helper"
require "cancan/matchers"

RSpec.describe Ability, type: :model do
	describe "User" do
		describe "abilities" do
			subject(:ability) { Ability.new(user) }
			let(:user) { User.create(email: "user@email.com", password: "asdfasdf", first_name: "user", last_name: "test") }


			context "when is an admin" do
				

				it "can manage Users" do
					user.roles = [:admin, :user]
					should be_able_to(:manage, User)
				end
			end

			context "when is a user" do
				it { should be_able_to(:destroy, :session) }
				it { should_not be_able_to(:create, User) }
				it { should_not be_able_to(:index, User) }
				it { should be_able_to(:show, user) }
				it { should_not be_able_to(:update, User.new) }
				it { should be_able_to(:update, user)}
				it { should_not be_able_to(:delete, User) }
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