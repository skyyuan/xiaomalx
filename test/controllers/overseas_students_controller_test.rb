require 'test_helper'

class OverseasStudentsControllerTest < ActionController::TestCase

  def setup

    @login_user =consultant_users(:login_user)
    @login_user1 =consultant_users(:login_user1)

    #学生的创建者都为login_user
    @normal_stadent = overseas_students(:normal_student) # fllow_up_status: 0 #0:表示跟进中，1：已签，2：无效
    @urgent_student = overseas_students(:urgent_student) # fllow_up_status: 1 #0:表示跟进中，1：已签，2：无效

    @student = {
  :name=>"学生名称",
#  :phone=>"13487699002",
  :relationship=> "家长",
  :contact_name=> "联络人名称",
  :contact_phone=> "联络人电话",
  :background=> "学员的背景与需求",
  :student_status=> 3,  #跟进要求（0:表示跟进中，1：常规，2：紧急，3：即将到访
  :comment=> "备注",
#  :fllow_up_status=> 1 #0:表示跟进中，1：已签，2：无效
#  creator_id: 1
    }
  end

  def test_create_student_success
    @student['token'] =  @login_user['token']
    @student[:phone]="13487699002"
    post :create_student,@student
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json

    assert_equal assigns[:overseas_student].fllow_up_status,0
    assert_equal assigns[:overseas_student].creator_id,1
    assert_equal assigns[:overseas_student].code,4
    assert_equal j["flag"],1
    assert_equal j["content"]['id'],assigns[:overseas_student][:id]

    @student['token'] =  @login_user['token']
    @student[:phone]="13487699003"
    post :create_student,@student

    assert_equal assigns[:overseas_student].code,5
  end

  def test_create_student_fail
    @student[:phone]="13487699001"
    post :create_student,@student
    j =ActiveSupport::JSON.decode(@response.body)
    assert_equal j["flag"],1001

    @student['token'] =  @login_user['token']
    post :create_student,@student
    j =ActiveSupport::JSON.decode(@response.body)
    assert_equal j["flag"],0
  end

  def test_get_student_info_success
    post :get_student_info,{:token=>@login_user['token'],:id=>1}
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
    assert_equal j["flag"],1
  end

  def test_get_student_info_fail
    post :get_student_info,{:token=>@login_user['token'],:id=>3}
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
    assert_equal j["flag"],1002
  end

  def test_get_students_list
    post :get_students_list,{:token=>@login_user['token'],:page_no=>1,:fllow_up_status=>-1}
    j =ActiveSupport::JSON.decode(@response.body)
    assert_equal j["flag"],1
    assert_equal j["content"]["students"].size,2

    post :get_students_list,{:token=>@login_user['token'],:page_no=>2,:fllow_up_status=>-1}
    j =ActiveSupport::JSON.decode(@response.body)
    assert_equal j["flag"],1
    assert_equal j["content"]["students"].size,0

    post :get_students_list,{:token=>@login_user['token'],:page_no=>1,:fllow_up_status=>0}
    j =ActiveSupport::JSON.decode(@response.body)
    assert_equal j["flag"],1
    assert_equal j["content"]["students"].size,1
    assert_equal j["content"]["students"][0]['id'],1

    post :get_students_list,{:token=>@login_user['token'],:page_no=>1,:fllow_up_status=>1}
    j =ActiveSupport::JSON.decode(@response.body)
    assert_equal j["flag"],1
    assert_equal j["content"]["students"].size,1
    assert_equal j["content"]["students"][0]['id'],2

  end

end
