class CreateIndividualLessons < ActiveRecord::Migration
  def change
    create_table :individual_lessons do |t|
      t.integer :student_id
      t.integer :student_admin_id
      t.string :lesson_name
      t.string :course_name
      t.string :teacher_name
      t.string :lesson_venue
      t.string :class_room
      t.date :lesson_date
      t.string :lesson_duration
      t.text :teacher_evaluate
      t.integer :curriculum_id
      t.timestamps
    end
  end
end
