class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :student_admin_id
      t.string :student_name
      t.string :student_picture
      t.string :account
      t.integer :school_hour
      t.string :identifying_code
      t.string :school_district
      t.string :student_type
      t.timestamps
    end
  end
end
