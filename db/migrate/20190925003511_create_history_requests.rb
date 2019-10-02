class CreateHistoryRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :history_requests do |t|
      t.string :library_name
      t.string :isbn
      t.string :status
      t.string :student_name
      t.string :student_email
      t.numeric :fines
      t.timestamps
    end
  end
end
