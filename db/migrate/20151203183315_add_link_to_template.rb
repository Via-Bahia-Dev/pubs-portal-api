class AddLinkToTemplate < ActiveRecord::Migration
  def change
  	add_column :templates, :link, :string
  end
end
