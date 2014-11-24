class AddIsLeaderToStaff < ActiveRecord::Migration
  def change
      add_column :users, :is_leader, :boolean, default: false
  end
end
