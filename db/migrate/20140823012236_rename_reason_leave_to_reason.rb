class RenameReasonLeaveToReason < ActiveRecord::Migration
  def change
    rename_column :leaves, :reason_leave, :reason
  end
end
