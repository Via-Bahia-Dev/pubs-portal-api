class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.integer :user_id
      t.string :dimensions

      t.timestamps null: false
    end
  end
end
