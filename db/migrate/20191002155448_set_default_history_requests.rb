class SetDefaultHistoryRequests < ActiveRecord::Migration[6.0]
  def change
    change_column_default :history_requests, :fines, 0
  end
end
