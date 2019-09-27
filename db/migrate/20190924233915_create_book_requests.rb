class CreateBookRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :book_requests do |t|
      t.integer :library_id
      t.string :isbn
      t.integer :books_available
      t.integer :books_checkedout
      t.integer :books_holdrequest

      t.timestamps
    end
  end
end
