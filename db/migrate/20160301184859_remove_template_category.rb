class RemoveTemplateCategory < ActiveRecord::Migration
  def change
    remove_column :templates, :category
  end
end
