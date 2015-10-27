require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.create(email: "user@email.com", password: "asdfasdf", first_name: "user", last_name: "test") }


  describe "db structure" do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string) }
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:roles_mask).of_type(:integer) }

    it { is_expected.to have_db_index(:email) }
  end

  describe "associations" do
    it { is_expected.to have_many(:authentication_tokens) }
    it { is_expected.to have_many(:publication_requests) }
    it { is_expected.to have_many(:request_attachments) }
    it { is_expected.to have_many(:requests_as_admin) }
    it { is_expected.to have_many(:requests_as_designer) }
    it { is_expected.to have_many(:requests_as_reviewer) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:templates) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe "secure password" do
    it { is_expected.to have_secure_password }
    # it { is_expected.to validate_length_of(:password) } 

    it { expect(User.new({ email: "user@email.com", password: nil, first_name: "user", last_name: "test" }).save).to be_falsey }
    it { expect(User.new({ email: "user@email.com", password: "foo", first_name: "user", last_name: "test" }).save).to be_falsey }
    it { expect(User.new({ email: "user@email.com", password: "af3714ff0ffae", first_name: "user", last_name: "test" }).save).to be_truthy }
  end

  describe "ROLES list" do
    it "should be [admin designer reviewer user banned]" do
      expect(User.ROLES).to eq(%i[admin designer reviewer user banned])
    end
  end

  describe "All new users have User role" do
    it do
      expect(user.has_role?(:user)).to eq(true)
    end
  end

  describe "Adding Roles" do
    it "should not replace other roles" do
      user.add_roles([:admin])
      expect(user.roles).to eq([:admin, :user])
    end

    it "multiple roles should work" do
      user.add_roles([:designer, :reviewer])
      expect(user.roles).to eq([:designer, :reviewer, :user])

      user.add_roles([:admin])
      expect(user.roles).to eq([:admin, :designer, :reviewer, :user])
    end
  end

  describe "setting Roles" do
    it "one role should work" do
      user.roles = [:admin]
      expect(user.roles).to eq([:admin])
    end

    it "should completely replace any old roles" do
      user.roles = [:admin]
      expect(user.roles).to eq([:admin])

      user.roles = [:designer, :user]
      expect(user.roles).to eq([:designer, :user])
    end
  end


  describe "getting Roles" do
    it "should only return valid roles" do
      user.roles = [:admin, :badRole]
      expect(user.roles).to eq([:admin])

      user.roles = [:garbage]
      expect(user.roles).to eq([])
    end
  end


end