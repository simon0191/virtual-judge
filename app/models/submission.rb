# == Schema Information
#
# Table name: submissions
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  problem_id  :integer
#  user_id     :integer
#  source_code :string(255)
#  language    :string(255)
#  result      :string(255)
#

class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  mount_uploader :source_code, SubmissionSourceCodeUploader

  validates :source_code, :language, :user_id, :problem_id, presence: true

  def execute_code
    input_path = self.problem.input && self.problem.input.file ? self.problem.input.file.file : nil
    source_code_path = self.source_code.file.file

    exec_result = DiscantExecutor.exec(source_code_path, input_path)
    if exec_result[:exit_status].success? && exec_result[:stdout] == self.problem.output
      self.result = "ACCEPTED"
      if self.created_at <= self.problem.max_date
        self.user.points += 10
      else
        self.user.points += 5
      end
    else
      self.result = "WRONG_ANSWER"
    end
    self.save
    self.user.save

  end

end
