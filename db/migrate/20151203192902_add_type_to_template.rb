class AddTypeToTemplate < ActiveRecord::Migration
  def change
  	add_column :templates, :category, :string
  end
end
