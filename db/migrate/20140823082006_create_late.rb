class CreateLate < ActiveRecord::Migration
  def change
    create_table :lates do |t|
      t.text :note

      t.references :staff

      t.timestamps
    end
  end
end
