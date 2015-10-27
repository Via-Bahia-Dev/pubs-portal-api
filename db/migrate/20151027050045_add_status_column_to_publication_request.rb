class AddStatusColumnToPublicationRequest < ActiveRecord::Migration
  def change
    add_column :publication_requests, :status, :string
  end
end
