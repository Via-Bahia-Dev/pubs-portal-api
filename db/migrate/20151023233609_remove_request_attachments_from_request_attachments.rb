class RemoveRequestAttachmentsFromRequestAttachments < ActiveRecord::Migration
  def change
  	remove_attachment :request_attachments, :request_attachments
  end
end
