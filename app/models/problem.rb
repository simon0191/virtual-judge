# == Schema Information
#
# Table name: problems
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  max_date    :date
#  language    :string(255)
#  solution    :string(255)
#  input       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Problem < ActiveRecord::Base
  mount_uploader :solution, ProblemSolutionUploader
  mount_uploader :input, ProblemInputUploader

  validates :name, :description, :max_date, :language,:solution, :input, presence: true

  validates :language, inclusion: { in: ["dis"]}

  validate :solution_is_valid

  private
  def solution_is_valid
    result = DiscantExecutor.exec(self.solution.file.file, self.input.file.file)
    if result[:exit_status].success?
      self.output = result[:stdout]
    else
      errors.add(:solution, "The execution of the solution wasn't successful")
    end
  end

end
