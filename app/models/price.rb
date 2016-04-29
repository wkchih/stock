class Price < ActiveRecord::Base

  scope :days, -> (num) { where("timestamp >= ? AND timestamp <= ?", Date.today - num, Date.today + 1) }

end
