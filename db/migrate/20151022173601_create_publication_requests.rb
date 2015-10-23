class CreatePublicationRequests < ActiveRecord::Migration
  def change
    create_table :publication_requests do |t|
      t.string :event
      t.text :description
      t.string :dimensions
      t.datetime :rough_date
      t.datetime :due_date
      t.datetime :event_date

      t.timestamps null: false
    end
  end
end
