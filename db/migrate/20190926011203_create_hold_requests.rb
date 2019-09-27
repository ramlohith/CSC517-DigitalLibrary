class CreateHoldRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :hold_requests do |t|
      t.string :student_email
      t.string :student_name
      t.string :isbn
      t.string :title
      t.string :author
      t.integer :edition
      t.string :university

      t.timestamps
    end
  end
end
