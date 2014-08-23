class CreateFeedback < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :type, default: 'feedback'
      t.text :content

      t.references :staff
      t.timestamp
    end
  end
end
