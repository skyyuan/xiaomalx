require 'test_helper'

class ConsultantUserControllerTest < ActionController::TestCase

  def setup
#   登录用户的电话单元退出用户的
    @sign_out_user =consultant_users(:sign_out_user)
    @login_user =consultant_users(:login_user)
    @user = {
#       :phone=>13488856781,
        :name=>"name",
        :encrypted_password=> "encrypted_password",
        :invitation_code=>"invitation_code",
        :institution_name=> "institution_name",
        :is_public=>0,
        :education_id=> "本科,研究生",
        :professional_id=> "金融,地理",
        :country_id=> "亚洲,美国"
    }
  end

   def test_register_success
    @user[:phone]=@login_user[:phone].to_i+1
    post :register,@user
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
    assert_equal j["flag"],1
    assert_not_nil j["content"]['uid']
    assert_not_nil j["content"]['token']
  end

  def test_register_fail
    @user[:phone]=@sign_out_user[:phone]
    post :register,@user
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
    assert_equal j["flag"],0
  end

  def test_login_in_success
    post :login_in,{:phone=>@login_user.phone,:encrypted_password=>@login_user.encrypted_password}
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
    assert_equal j["flag"],1
    assert_not_nil j["content"]['uid']
    assert_equal j["content"]['token'],@login_user.token


    post :login_in,{:phone=>@sign_out_user.phone,:encrypted_password=>@sign_out_user.encrypted_password}
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
    assert_equal j["flag"],1
    assert_not_nil j["content"]['uid']
    assert_not_nil j["content"]['token']

  end

  def test_login_in_fail
    post :login_in,{:phone=>@login_user.phone,:encrypted_password=>@login_user.encrypted_password+"123"}
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
    assert_equal j["flag"],0
  end

  def test_sign_out_success
    post :sign_out,{:token=>@login_user.token}
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
#    p assigns[:current_user]
    assert_equal j["flag"],1
    assert_nil assigns[:current_user].token
  end

  def test_authorize_consultant_user
    post :sign_out
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
#    p assigns[:current_user]
    assert_equal j["flag"],1001
  end

  def test_get_consultant_user_info_success
    post :get_consultant_user_info,{:token=>@login_user.token}
    j =ActiveSupport::JSON.decode(@response.body)
#    p j.to_json
    assert_equal j["flag"],1
  end

  def test_phone_exist
    post :phone_exist,{:phone=>@login_user.phone}
    j =ActiveSupport::JSON.decode(@response.body)
    assert_equal j["flag"],0

    post :phone_exist,{:phone=>"13488856782"}
    j =ActiveSupport::JSON.decode(@response.body)
    assert_equal j["flag"],1
  end

  def test_forget_password
    post :forget_password,{:phone=>@sign_out_user.phone,:encrypted_password=>"123"}
    j =ActiveSupport::JSON.decode(@response.body)
    u = ConsultantUser.where({:uid=>@sign_out_user.uid}).first
    assert_equal u.encrypted_password,'123'
    assert_equal j["flag"],1
  end

end
