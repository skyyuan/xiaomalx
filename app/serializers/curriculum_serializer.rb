class CurriculumSerializer < ActiveModel::Serializer
  attributes :id, :arrival_school, :leave_school
  has_many :individual_lessons
end
