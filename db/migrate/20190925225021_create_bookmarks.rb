class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :student_name
      t.string :student_email
      t.string :isbn
      t.string :title
      t.string :author
      t.integer :edition
      t.timestamps
    end
  end
end
