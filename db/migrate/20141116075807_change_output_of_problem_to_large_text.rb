class ChangeOutputOfProblemToLargeText < ActiveRecord::Migration
  def change
    change_column :problems, :output, :text, :limit => 65536
  end
end
