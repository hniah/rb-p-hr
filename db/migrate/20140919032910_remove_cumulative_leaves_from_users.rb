class RemoveCumulativeLeavesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :cumulative_leaves
  end
end
