class OverseasStudentSerializer < ActiveModel::Serializer
  attributes :id,:code, :name, :phone,:relationship, :contact_name, :contact_phone,:background,:student_status,:comment, :fllow_up_status
end
