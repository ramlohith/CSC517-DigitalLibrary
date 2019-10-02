class HistoryRequest < ApplicationRecord
  def calculatefines(maxdays,fine)
   if (Time.now - self.updated_at)/86400 > 1

    if self.status == "Checked Out"
     daysdiff = (Time.now - self.updated_at) / 86400

      if daysdiff > maxdays && !self.fines.nil?
        self.fines = self.fines + fine
      else
        self.fines = 0
      end
   end
   end
   self
  end
end