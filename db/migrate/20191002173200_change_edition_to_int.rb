class ChangeEditionToInt < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :edition, 'integer USING CAST(edition AS integer)'
  end
end
