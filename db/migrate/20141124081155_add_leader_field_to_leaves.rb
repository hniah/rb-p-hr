class AddLeaderFieldToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :leader, :string
  end
end
