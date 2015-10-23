class AddUserIdColumnToPublicationRequests < ActiveRecord::Migration
  def change
    add_column :publication_requests, :user_id, :integer
  end
end
