class CreateRequestAttachments < ActiveRecord::Migration
  def change
    create_table :request_attachments do |t|
    	t.attachment :request_attachments, :file
      t.timestamps null: false
    end
  end
end
