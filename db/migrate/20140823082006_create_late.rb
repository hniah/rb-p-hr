class CreateLate < ActiveRecord::Migration
  def change
    create_table :lates do |t|
      t.text :note

      t.references :staff

      t.timestamp
    end
  end
end
