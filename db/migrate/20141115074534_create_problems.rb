class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :name
      t.text :description
      t.date :max_date
      t.string :language
      t.string :solution
      t.string :input

      t.timestamps
    end
  end
end
