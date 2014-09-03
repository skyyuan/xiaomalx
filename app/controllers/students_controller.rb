#encoding : utf-8
require 'digest/md5'
class StudentsController < ApplicationController
  before_filter :authorize_student_admin!, :except => [:code]
  skip_before_filter :verify_authenticity_token, :only => [:code]
    # layout 'student_admin'
  def index
    if params[:query].blank?
      @students = Student.where(student_admin_id: session[:teacher_id])
    else
      @students = Student.where("student_name like '%#{params[:query]}%'")
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])
    session[:student_id] = @student.id
    redirect_to curriculums_path
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create

    @student = Student.new(params[:student])
    #@student.account = params[:account]
    @student.password = [*'0'..'9'].sample(6).join
    @student.student_admin_id = session[:teacher_id]
    @student.student_picture = 'http://procket.oss-cn-hangzhou.aliyuncs.com/Picture/2014/07/07/BD7E9798-4DE6-408A-A75C-66199598AF72'

    respond_to do |format|
      if @student.save
          format.html { redirect_to students_path, alert: '学员增加成功！' }
      else
          format.html { render action: 'new' }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  def census
    student_ids = Student.where(student_admin_id: session[:teacher_id]).map &:id
    @students = Curriculum.select("curriculums.*").where(student_id: student_ids, course_date: params[:begin_date])
  end

  def code
    @student = Student.find_by_identifying_code(params[:code]) if params[:code]
    respond_to do |format|
      if @student.present?
        format.json { render json: @student }
      else
        format.json { render json: {status: 0} }
      end
    end
  end
end
