class AddSourceCodeToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :source_code, :string
  end
end
