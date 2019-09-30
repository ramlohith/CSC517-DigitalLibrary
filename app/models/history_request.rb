class HistoryRequest < ApplicationRecord
  def calculatefines(maxdays,fine)
   if self.status == "Checked Out"
      daysdiff = (Time.now - self.updated_at) / 86400

      if daysdiff > maxdays
        self.fines = self.fines + fine
      else
        self.fines = 0
      end
   end
   self
  end
end