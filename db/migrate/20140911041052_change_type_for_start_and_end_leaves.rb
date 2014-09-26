class ChangeTypeForStartAndEndLeaves < ActiveRecord::Migration
  def change
    change_column :leaves, :start, :datetime
    change_column :leaves, :end, :datetime
  end
end
