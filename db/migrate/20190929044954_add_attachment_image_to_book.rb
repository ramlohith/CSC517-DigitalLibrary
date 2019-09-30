class AddAttachmentImageToBook < ActiveRecord::Migration[6.0]
  def change
    add_attachment :books, :image
  end
end
