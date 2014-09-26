class AddDateToLates < ActiveRecord::Migration
  def change
    change_table :lates do |t|
      t.date :date
    end
  end
end
