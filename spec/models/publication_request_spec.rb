require 'rails_helper'

RSpec.describe PublicationRequest, type: :model do

  let(:publication_request) { PublicationRequest.create(event: "PR model spec", description: "this is fun.",  rough_date: "Mon, 17 Dec 2015 00:00:00 +0000", due_date: "Mon, 17 Dec 2015 00:00:00 +0000", event_date: "Mon, 17 Dec 2015 00:00:00 +0000", dimensions: "quarter", user_id: 1 ) }

  describe "db structure" do
    it { is_expected.to have_db_column(:event).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:rough_date).of_type(:datetime) }
    it { is_expected.to have_db_column(:due_date).of_type(:datetime) }
    it { is_expected.to have_db_column(:event_date).of_type(:datetime) }
    it { is_expected.to have_db_column(:dimensions).of_type(:string) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:admin_id).of_type(:integer) }
    it { is_expected.to have_db_column(:reviewer_id).of_type(:integer) }
    it { is_expected.to have_db_column(:designer_id).of_type(:integer) }
    it { is_expected.to have_db_column(:template_id).of_type(:integer) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:designer) }
    it { is_expected.to belong_to(:admin) }
    it { is_expected.to belong_to(:reviewer) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:template) }
    it { is_expected.to belong_to(:status) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:event) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:rough_date) }
    it { is_expected.to validate_presence_of(:due_date) }
    it { is_expected.to validate_presence_of(:event_date) }
    it { is_expected.to validate_presence_of(:dimensions) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:admin_id) }
    it { is_expected.to validate_presence_of(:reviewer_id) }
    it { is_expected.to validate_presence_of(:designer_id) }
    it { is_expected.to validate_presence_of(:status_id) }
  end

end
