class AddFinesToHistoryRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :history_requests, :fines, :numeric
  end
end
