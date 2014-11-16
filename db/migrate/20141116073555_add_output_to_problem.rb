class AddOutputToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :output, :string
  end
end
