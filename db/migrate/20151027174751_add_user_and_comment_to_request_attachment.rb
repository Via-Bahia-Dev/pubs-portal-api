class AddUserAndCommentToRequestAttachment < ActiveRecord::Migration
  def change
  	add_column :request_attachments, :user_id, :integer
  	add_foreign_key :request_attachments, :users

  	add_column :request_attachments, :comment, :text
  end
end
