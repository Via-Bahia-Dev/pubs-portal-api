class AddColorOrderToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :color, :integer
    add_column :statuses, :order, :integer
  end
end
