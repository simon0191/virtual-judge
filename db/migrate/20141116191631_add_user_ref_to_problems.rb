class AddUserRefToProblems < ActiveRecord::Migration
  def change
    add_reference :problems, :problem_setter, index: true
  end
end
