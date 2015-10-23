require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:comment) { Comment.create(user_id: 1, content: "This is the best flyer ever.", date: "Mon, 17 Dec 2016 00:05:00 +0000", publication_request_id: 1 ) }

  describe "db structure" do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:content).of_type(:text) }
    it { is_expected.to have_db_column(:date).of_type(:datetime) }
    it { is_expected.to have_db_column(:publication_request_id).of_type(:integer) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:publication_request) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:publication_request_id) }
  end
end
