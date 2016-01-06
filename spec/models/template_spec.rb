require 'rails_helper'

RSpec.describe Template, type: :model do

  let(:template) { Template.create(name: "2015 NSWN Flyer", dimensions: "5x7", user_id: 1) }

  describe "paperclip attachment" do 
    it { should have_attached_file(:image) }
    it { should validate_attachment_presence(:image) }
    it { should validate_attachment_content_type(:image).
                allowing('image/png', 'image/jpg', 'image/jpeg', 'image/gif').
                rejecting('text/plain', 'text/xml' 'text/html', 'application/x-javascript', 'application/x-rar-compressed', 'application/zip', 'application/pdf') }
  end

  describe "db structure" do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:dimensions).of_type(:string) }
    it { is_expected.to have_db_column(:link).of_type(:string) }
    it { is_expected.to have_db_column(:category).of_type(:string) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:dimensions) }
  end
end
