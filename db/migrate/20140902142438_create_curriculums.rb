class CreateCurriculums < ActiveRecord::Migration
  def change
    create_table :curriculums do |t|
      t.integer :student_id
      t.string :course_title
      t.text :course_content
      t.date :course_date
      t.timestamps
    end
  end
end
