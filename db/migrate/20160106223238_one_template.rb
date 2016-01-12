class OneTemplate < ActiveRecord::Migration
  def change
  	drop_table :publication_requests_templates

  	add_column :publication_requests, :template_id, :integer
  end
end
