class ChangeRequestStatus < ActiveRecord::Migration
  def change
    change_table :publication_requests do |t|
      t.remove :status
      t.belongs_to :status, index: true
    end
  end
end
