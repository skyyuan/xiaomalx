class CreateElectives < ActiveRecord::Migration
  def change
    create_table :electives do |t|
      t.string :course_name
      t.date :lesson_date
      t.string :lesson_venue
      t.string :course_introduction
      t.string :lesson_duration
      t.timestamps
    end
  end
end
