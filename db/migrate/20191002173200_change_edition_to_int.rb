class ChangeEditionToInt < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :edition, 'integer USING CAST(column_name AS integer)'
end
