class RemoveLeaveDays < ActiveRecord::Migration
  def change
    drop_table :leave_days
  end
end
