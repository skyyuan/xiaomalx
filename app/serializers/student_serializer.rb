class StudentSerializer < ActiveModel::Serializer
  attributes :status, :id, :student_name, :student_picture, :school_hour, :surplus_count, :student_admin_name, :student_admin_phone

  def status
    1
  end

  def surplus_count
    object.school_hour - object.individual_lessons.where("student_id = ? and lesson_date < ?", object.id, Time.now.strftime('%Y-%m-%d')).count
  end

  def student_admin_name
    object.student_admin.name if object.student_admin
  end

  def student_admin_phone
    object.student_admin.phone if object.student_admin
  end
end