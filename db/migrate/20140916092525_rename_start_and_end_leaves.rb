class RenameStartAndEndLeaves < ActiveRecord::Migration
  def change
    rename_column :leaves, :start, :start_day
    rename_column :leaves, :end, :end_day
  end
end
