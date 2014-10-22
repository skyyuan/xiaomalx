#encoding : utf-8
class OverseasStudentsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authorize_consultant_user
  before_action :set_overseas_student, only: [:get_student_info]

  # 查看学生列表的接口(现在每页10条数据,首页page_no为1，依次递增，判断时候还有数据请自己根据students的数据进行判断)
  # URL:overseas_students/get_students_list
  # Methon:Post
  # Params:
  # {
  #   token       token
  #   page_no     页码
  #   fllow_up_status 跟进状态（0:表示跟进中，1：已签，2：无效,-1:表示不根据该字段过滤）
  # }
  #Return:
  # 成功
  # {
  #     flag:1,
  #     tips:'成功',
  #     content:{
  #       students:[
  #         {
  #           id,             数据库编号
  #           code,           编号
  #           name,           学员
  #           fllow_up_status 跟进状态（0:表示跟进中，1：已签，2：无效）
  #         }
  #       ]
  #     }
  #     time:'2014-01-01 10:20:10'
  #}

  def get_students_list
    # 拉动的时候的请求需要再讨论一下
    page_size =10
    offset = params['page_no'].to_i*page_size-page_size
    offset = 0 if offset<0
    conditions = {:creator_id=>@current_user.uid}
    conditions[:fllow_up_status]=params['fllow_up_status'].to_i if params['fllow_up_status'].to_i!=-1
    @overseas_students = OverseasStudent.where(conditions).order(:id).limit(page_size).offset(offset)

    render_success_json('成功',{:students=>repack_overseas_student(@overseas_students,[:id,:code,:name,:fllow_up_status])})
  end

  # 查看学生详细情况的接口（有关佣金的数据，等原型定了之后，再补充）
  # URL:overseas_students/get_student_info
  # Methon:Post
  # Params:
  # {
  #   token       token
  #   id          数据库id
  # }
  #Return:
  # 成功：
  #{
  #     flag:1,
  #     tips:'成功',
  #     content:{
  #       id,                数据库id
  #       code,              学生编号
  #       name,              学生名称
  #       phone,             学生电话
  #       relationship,      联络人关系
  #       contact_name,      联络人名称
  #       contact_phone,     联络人电话
  #       background,        学员的背景与需求
  #       student_status,    跟进要求（0:表示跟进中，1：常规，2：紧急，3：即将到访）
  #       comment,           备注
  #       fllow_up_status    跟进状态（0:表示跟进中，1：已签，2：无效）

  #       sign_amount        签约金额
  #       sign_commission_discount   签约返佣折扣
  #       sign_return_amount  返佣金额
  #       sign_return_date    预计返佣时间

  #       renew_amount       续费金额
  #       renew_commission_discount  签约返佣折扣
  #       renew_return_amount 返佣金额
  #       renew_return_date   预计返佣时间

  #       return_amount       实际返佣金额
  #     },
  #     time:'2014-01-01 10:20:10'
  # }
  # 没有权限查看该用户(为了防止被Hack的情况),以后所有没有权限的事情都用1002来标示，请前端处理的时候添加为常量:
  #{
  #     flag:1002,
  #     tips:'没有权限查看该学生信息',
  #     content:{},
  #     time:'2014-01-01 10:20:10'
  # }
  def get_student_info
    render_success_json('成功',repack_overseas_student(@overseas_student))
  end

  # 录入学生的接口
  # URL:overseas_students/create_student
  # Methon:Post
  # Params:
  # {
  #   token              token
  #   name,              学生名称
  #   phone,             学生电话
  #   relationship,      联络人关系
  #   contact_name,      联络人名称
  #   contact_phone,     联络人电话
  #   background,        学员的背景与需求
  #   student_status,    跟进要求（0:表示跟进中，1：常规，2：紧急，3：即将到访
  #   comment,           备注
  # }
  #Return:
  # 成功：
  #{
  #     flag:1,
  #     tips:'添加成功',
  #     content:{
  #       id,                数据库id
  #     },
  #     time:'2014-01-01 10:20:10'
  # }
  # 失败:
  #{
  #     flag:0,
  #     tips:'添加失败',
  #     content:{
  #       name:['学生名字不能为空']
  #       phone:['该手机已经注册']
  #     },
  #     time:'2014-01-01 10:20:10'
  # }
  def create_student
    @overseas_student = OverseasStudent.new(overseas_student_params)
    if @overseas_student.save
      render_success_json('添加成功',{'id'=>@overseas_student.id})
    else
      error_arr = []
      @overseas_student.errors.messages.each do |u,value|
        error_arr << value
      end
      render_failure_json(error_arr.join(","),{'error'=>0})
    end
  end

  # 目前没需求
  # def update_student
  #   respond_to do |format|
  #     if @overseas_student.update(overseas_student_params)
  #       format.html { redirect_to @overseas_student, notice: 'Overseas student was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @overseas_student.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy_student
  #   @overseas_student.destroy
  #   respond_to do |format|
  #     format.html { redirect_to overseas_students_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_overseas_student
    @overseas_student = OverseasStudent.where({id:params[:id],:creator_id=>@current_user.uid}).first
    if @overseas_student.blank?
      render_access_denied_json('没有权限查看该学生信息')
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def overseas_student_params
    params.permit(:code, :name, :phone,:relationship, :contact_name, :contact_phone,:background,:student_status,:comment, :fllow_up_status)
  end

  def repack_overseas_student(students,fileds=nil)
    json = []

    unless students.blank?
      repack_fileds = [
          :id,:code,:name,:phone,:relationship,:contact_name,
          :contact_phone,:background,:student_status, :comment, :fllow_up_status,
          :sign_amount,:sign_commission_discount,:sign_return_amount,:sign_return_date,
          :renew_amount,:renew_commission_discount,:renew_return_amount,:renew_return_date,
          :return_amount
      ]
      repack_fileds = fileds  unless fileds.blank?
      model_flag = false

      if students.class==OverseasStudent
        students =[students]
        model_flag = true
      end

      students.each do |student|
        model = {}
        repack_fileds.each do |filed|
          if filed ==:code
            model[filed] = student[:created_at].strftime("%y%m%d")+"_"+sprintf('%03d',student[filed])
          else
            model[filed] = student[filed]
          end
        end
        json << model
      end
      if model_flag
        return json.first
      end
    end
    return json
  end

end
