class AddFieldsToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :start, :date
    add_column :leaves, :end, :date
    add_column :leaves, :sub_cate, :string
    add_column :leaves, :count, :integer
  end
end
