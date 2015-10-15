require 'rails_helper'

RSpec.describe User, type: :model do

  describe "db structure" do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string) }
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }

    it { is_expected.to have_db_index(:email) }
  end

  describe "associations" do
    it { is_expected.to have_many(:authentication_tokens) }
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

end