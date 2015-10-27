class AddPublicationRequestIdToRequestAttachment < ActiveRecord::Migration
  def change
  	add_column :request_attachments, :publication_request_id, :integer
  	add_foreign_key :request_attachments, :publication_requests
  end
end
