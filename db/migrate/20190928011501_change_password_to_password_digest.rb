class ChangePasswordToPasswordDigest < ActiveRecord::Migration[6.0]
  def change
    rename_column :librarians, :password, :password_digest
    rename_column :admins, :password, :password_digest
  end
end
