class AddLeaderAndIsLeaderToUsers < ActiveRecord::Migration
  def change
      add_column :users, :is_leader, :boolean, default: false
      add_column :users, :leader, :string
  end
end
