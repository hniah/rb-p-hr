class AddTypesToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :types, :string
  end
end
