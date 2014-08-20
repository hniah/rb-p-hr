class CreateLeave < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.date :date
      t.string :kind
      t.text :reason_leave
      t.references :staff
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end
