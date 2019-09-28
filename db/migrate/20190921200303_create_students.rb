class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :education
      t.string :university
      t.integer :maxbook

      t.timestamps
    end
  end
end
