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
					should be_able_to(:manage, User.new)
				end
			end

			context "when is a user" do
				it "can sign out" do
					should be_able_to(:destroy, :session)
				end
			end
		end
	end
end