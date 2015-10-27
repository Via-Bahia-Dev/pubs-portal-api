require 'rails_helper'

RSpec.describe RequestAttachment, type: :model do

	describe "paperclip attachment" do 
	  it { should have_attached_file(:file) }
	  it { should validate_attachment_presence(:file) }
	  it { should validate_attachment_content_type(:file).
	  						allowing('image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'application/x-rar-compressed', 'application/zip', 'application/pdf').
	  						rejecting('text/plain', 'text/xml' 'text/html', 'application/x-javascript') }
	end

	describe "db structure" do
		it { is_expected.to have_db_column(:publication_request_id).of_type(:integer) }
		it { is_expected.to have_db_column(:user_id).of_type(:integer) }
	end

	describe "associations" do 
		it { is_expected.to belong_to(:publication_request) }
		it { is_expected.to belong_to(:user) }
	end

	describe "validations" do
    it { is_expected.to validate_presence_of(:publication_request_id) }
    it { is_expected.to validate_presence_of(:user_id) }
  end
end
