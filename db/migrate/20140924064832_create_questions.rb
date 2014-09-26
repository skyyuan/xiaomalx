class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :elder_id
      t.integer :preview, :default => 0
      t.integer :answer_count, :default => 0

      t.timestamps
    end
  end
end
