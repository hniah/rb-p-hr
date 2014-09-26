class ChangeTypeForTotalLeaves < ActiveRecord::Migration
  def change
    change_column :leaves, :total, :float
  end
end
