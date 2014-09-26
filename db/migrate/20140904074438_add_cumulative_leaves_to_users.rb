class AddCumulativeLeavesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cumulative_leaves, :float, default: 0
  end
end
