class CreateCommonProblems < ActiveRecord::Migration
  def change
    create_table :common_problems do |t|
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
