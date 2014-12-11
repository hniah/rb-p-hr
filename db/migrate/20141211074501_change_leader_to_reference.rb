class ChangeLeaderToReference < ActiveRecord::Migration
  def change
    remove_column :users, :leader
    add_reference :users, :leader
  end
end
