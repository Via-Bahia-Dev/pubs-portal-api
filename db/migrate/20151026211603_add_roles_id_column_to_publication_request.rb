class AddRolesIdColumnToPublicationRequest < ActiveRecord::Migration
  def change
    add_column :publication_requests, :designer_id, :integer
    add_column :publication_requests, :admin_id, :integer
    add_column :publication_requests, :reviewer_id, :integer
  end
end
