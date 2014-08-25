class CreateLeaveDays < ActiveRecord::Migration
  def change
    create_table :leave_days do |t|
      t.date :date
      t.string :kind

      t.references :leave

      t.timestamps
    end
  end
end
