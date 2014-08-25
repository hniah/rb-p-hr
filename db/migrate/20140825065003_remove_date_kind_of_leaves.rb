class RemoveDateKindOfLeaves < ActiveRecord::Migration
  def change
    remove_column :leaves, :date
    remove_column :leaves, :kind
  end
end
