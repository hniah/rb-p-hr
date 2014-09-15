class RenameCountToTotalForLeaves < ActiveRecord::Migration
  def change
    rename_column :leaves, :count, :total
  end
end
