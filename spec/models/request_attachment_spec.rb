require 'rails_helper'

RSpec.describe RequestAttachment, type: :model do
  it { should have_attached_file(:file) }
  it { should validate_attachment_presence(:file) }
  it { should validate_attachment_content_type(:file).
  						allowing('image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'application/x-rar-compressed', 'application/zip', 'application/pdf').
  						rejecting('text/plain', 'text/xml' 'text/html', 'application/x-javascript') }
end
