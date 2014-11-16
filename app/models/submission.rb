# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  problem_id :integer
#  user_id    :integer
#

class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem
end
