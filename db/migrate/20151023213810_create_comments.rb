class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :publication_request_id
      t.datetime :date
      t.text :content

      t.timestamps null: false
    end
  end
end
