class AddReasonNoteForLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :reason_note, :text
  end
end
