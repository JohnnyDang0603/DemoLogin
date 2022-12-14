# == Schema Information
#
# Table name: timesheets
#
#  id         :integer          not null, primary key
#  check_in   :time
#  check_out  :time
#  day        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_timesheets_on_user_id  (user_id)
#
require "test_helper"

class TimesheetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
