class CreateSupplementLessons < ActiveRecord::Migration
  def change
    create_table :supplement_lessons do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.string :lesson_name
      t.string :course_name
      t.string :teacher_name
      t.string :lesson_venue
      t.string :class_room
      t.date :lesson_date
      t.string :lesson_duration
      t.text :student_score
      t.integer :curriculum_id
      t.timestamps
    end
  end
end
