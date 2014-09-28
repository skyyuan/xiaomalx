class CreateQuestionTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|
      t.integer :question_id
      t.integer :level_id
      t.integer :country_id
      t.integer :profe_id
      t.integer :other_id

      t.timestamps
    end
  end
end