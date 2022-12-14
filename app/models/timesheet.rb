class Timesheet < ApplicationRecord
  resourcify
  belongs_to :user
end
