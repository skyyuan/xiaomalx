class IndividualLessonSerializer < ActiveModel::Serializer
  attributes :id, :class_room,:lesson_duration, :lesson_name, :teacher_name, :teacher_evaluate, :course_name
end
