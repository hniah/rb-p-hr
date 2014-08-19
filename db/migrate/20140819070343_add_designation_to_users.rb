class AddDesignationToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :designation
    end
  end
end
