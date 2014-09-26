class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :title
      t.integer :question_id
      t.integer :object_id
      t.integer :consultant, default: 0
      t.integer :praise, default: 0
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :children_count, :default => 0

      t.timestamps
    end
  end
end
