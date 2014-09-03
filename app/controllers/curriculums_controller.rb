#encoding : utf-8
class CurriculumsController < ApplicationController
    before_filter :authorize_student_admin!, :except => [:quer_hour, :same_month]
  def index
    @curriculums = Curriculum.where(student_id: session[:student_id]).order('course_date DESC')

    respond_to do |format|
      format.html
    end
  end

  # GET /curriculums/1
  # GET /curriculums/1.json
  def show
    @curriculum = Curriculum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @curriculum }
    end
  end

  # GET /curriculums/new
  # GET /curriculums/new.json
  def new
    @curriculum = Curriculum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @curriculum }
    end
  end

  # GET /curriculums/1/edit
  def edit
    @curriculum = Curriculum.find(params[:id])
  end

  def add1
    @curriculum = Curriculum.find(params[:id])
  end

  def add2
    @curriculum = Curriculum.find(params[:id])
  end

  # POST /curriculums
  # POST /curriculums.json
  def create
    @curriculum = Curriculum.new(params[:curriculum])
    @curriculum.student_id = session[:student_id]

    respond_to do |format|
      if @curriculum.save

        if Student.find_by_id(session[:student_id]).student_type == "1"
          fu1 = SupplementLesson.create(lesson_name: "辅课", course_name: "听力", curriculum_id: @curriculum.id,student_id: session[:student_id],lesson_date: @curriculum.course_date, teacher_id: session[:teacher_id], class_room:"",teacher_name:"",lesson_duration:"",lesson_venue: "")
          fu2 = SupplementLesson.create(lesson_name: "辅课", course_name: "词汇", curriculum_id: @curriculum.id,student_id: session[:student_id],lesson_date: @curriculum.course_date, teacher_id: session[:teacher_id], class_room:"",teacher_name:"",lesson_duration:"",lesson_venue: "")
          fu3 = SupplementLesson.create(lesson_name: "辅课", course_name: "互译", curriculum_id: @curriculum.id,student_id: session[:student_id],lesson_date: @curriculum.course_date, teacher_id: session[:teacher_id], class_room:"",teacher_name:"",lesson_duration:"",lesson_venue: "")
          fu1.save
          fu2.save
          fu3.save
        elsif Student.find_by_id(session[:student_id]).student_type == "2"
          fu1 = SupplementLesson.create(lesson_name: "辅课", course_name: "核心词汇", curriculum_id: @curriculum.id,student_id: session[:student_id],lesson_date: @curriculum.course_date, teacher_id: session[:teacher_id], class_room:"",teacher_name:"",lesson_duration:"",lesson_venue: "")
          fu2 = SupplementLesson.create(lesson_name: "辅课", course_name: "核心精读阅读", curriculum_id: @curriculum.id,student_id: session[:student_id],lesson_date: @curriculum.course_date, teacher_id: session[:teacher_id], class_room:"",teacher_name:"",lesson_duration:"",lesson_venue: "")
          fu3 = SupplementLesson.create(lesson_name: "辅课", course_name: "核心精读写作", curriculum_id: @curriculum.id,student_id: session[:student_id],lesson_date: @curriculum.course_date, teacher_id: session[:teacher_id], class_room:"",teacher_name:"",lesson_duration:"",lesson_venue: "")
          fu1.save
          fu2.save
          fu3.save
        elsif Student.find_by_id(session[:student_id]).student_type == "3"
          fu1 = SupplementLesson.create(lesson_name: "辅课", course_name: "SAT长短句", curriculum_id: @curriculum.id,student_id: session[:student_id],lesson_date: @curriculum.course_date, teacher_id: session[:teacher_id], class_room:"",teacher_name:"",lesson_duration:"",lesson_venue: "")
          fu2 = SupplementLesson.create(lesson_name: "辅课", course_name: "SAT填空词汇", curriculum_id: @curriculum.id,student_id: session[:student_id],lesson_date: @curriculum.course_date, teacher_id: session[:teacher_id], class_room:"",teacher_name:"",lesson_duration:"",lesson_venue: "")
          fu1.save
          fu2.save
        end



        format.html { redirect_to curriculums_path, alert:'课程日历添加成功！' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /curriculums/1
  # PUT /curriculums/1.json
  def update
    @curriculum = Curriculum.find(params[:id])

    respond_to do |format|
      if @curriculum.update_attributes(params[:curriculum])
          format.html { redirect_to curriculums_path, alert:'课程日历更新成功！' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /curriculums/1
  # DELETE /curriculums/1.json
  def destroy
    @curriculum = Curriculum.find(params[:id])
    @curriculum.destroy

    respond_to do |format|
      format.html { redirect_to curriculums_url }
      format.json { head :no_content }
    end
  end

  def same_month
   @curriculum = Curriculum.where(['course_date like ? and student_id = ?', "%#{params[:date]}%", params[:student_id]]).order("course_date asc").map &:course_date
   respond_to do |format|
      format.json { render json: @curriculum }
    end
  end

  def quer_hour
   @curriculum = Curriculum.where(student_id: params[:student_id], course_date: params[:date_time].to_date.strftime('%Y-%m-%d'))
   respond_to do |format|
      format.json { render json: @curriculum }
    end
  end
end
