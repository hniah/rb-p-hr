class CreateLeave < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.date :date
      t.string :status
      t.string :category
      t.string :kind

      t.text :reason
      t.text :rejection_note

      t.references :staff

      t.timestamps
    end
  end
end
