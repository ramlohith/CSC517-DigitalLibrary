class AddStatusToLibrarian < ActiveRecord::Migration[6.0]
  def change
    add_column :librarians, :status, :string
  end
end
