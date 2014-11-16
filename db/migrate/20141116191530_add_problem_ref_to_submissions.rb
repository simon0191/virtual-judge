class AddProblemRefToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :problem, index: true
  end
end
