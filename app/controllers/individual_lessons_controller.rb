class IndividualLessonsController < ApplicationController
  before_filter :authorize_student_admin!, :except => [:course]
  def course
    @individual_lesson = IndividualLesson.find(params[:individual_lesson_id])
    @supplement_lesson = @individual_lesson.curriculum.supplement_lessons.select("id,student_score")
    json_respond = {individual:{:individual_lesson => @individual_lesson, :supplement_lesson =>@supplement_lesson}}

    respond_to do |format|
      format.json {render json: json_respond }
    end
  end
end
