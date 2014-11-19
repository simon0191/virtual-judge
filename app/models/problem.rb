# == Schema Information
#
# Table name: problems
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  max_date          :date
#  language          :string(255)
#  solution          :string(255)
#  input             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  output            :text(65536)
#  problem_setter_id :integer
#

class Problem < ActiveRecord::Base

  belongs_to :problem_setter, :class_name => 'User', :foreign_key => 'problem_setter_id'
  has_many :submissions
  has_many :submitters, through: :submissions, source: :user


  mount_uploader :solution, ProblemSolutionUploader
  mount_uploader :input, ProblemInputUploader

  validates :name, :description, :max_date, :language,:solution, presence: true

  validates :language, inclusion: { in: ["dis"]}

  validate :solution_is_valid
  validate :problem_setter_is_admin

  private
  def solution_is_valid
    input_path = self.input && self.input.file ? self.input.file.file : nil
    solution_path = self.solution.file.file

    result = DiscantExecutor.exec(solution_path, input_path)
    if result[:exit_status].success?
      self.output = result[:stdout]
    else
      errors.add(:solution, "The execution of the solution wasn't successful")
    end
  end

  def problem_setter_is_admin
    unless self.problem_setter.role == "admin"
      errors.add(:problem_setter, "The problem setter should be admin")
    end
  end

end
