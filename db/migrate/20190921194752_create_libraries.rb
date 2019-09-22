class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :university
      t.string :location
      t.integer :maxdays
      t.numeric :fine

      t.timestamps
    end
  end
end
