class CreateLibrarians < ActiveRecord::Migration[6.0]
  def change
    create_table :librarians do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :library
      t.timestamps
      t.string :status
    end
  end
end
