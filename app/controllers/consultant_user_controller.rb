#encoding : utf-8
class ConsultantUserController < ApplicationController

  before_filter :authorize_consultant_user, :except => [:register,:login_in]

  #留学顾问注册的接口
  #URL:consultant_user/register
  #Methon:Post
  #Params：
  # {
  #   phone                 电话,
  #   name                  名称、昵称
  #   encrypted_password    加密之后的密码
  #   invitation_code       邀请码
  #   institution_name      机构名称
  #   is_public             是否公开(1：公开，0：不公开)
  #   education_id          擅长学历层次（多个学历之间使用逗号分隔）
  #   professional_id       擅长专业（多个专业之间使用逗号分隔）
  #   country_id            擅长国家（多个国家之间使用逗号分隔）
  # }
  # Return:
  # 成功
  # {
  #     flag:1,
  #     tips:'注册成功',
  #     content:{uid:1,token:klsfdsdfs1234},
  #     time:'2014-01-01 10:20:10'
  # }
  # 失败
  # {
  #     flag:0,
  #     tips:'注册失败',
  #     content:{
  #       education_id:['擅长学历不能为空']
  #       phone:['该手机已经注册']
  #     },
  #     time:'2014-01-01 10:20:10'
  # }
  def register
    user = ConsultantUser.new(consultant_user_params)
    if user.save
      user.login
      render_success_json('注册成功',{'uid'=>user.uid,'token'=>user.token})
    else
      render_failure_json('注册失败',user.errors.messages)
    end
  end

  #顾问登陆的接口
  #URL:consultant_user/login_in
  #Methon:Post
  #Params：{
  #   phone                 电话,
  #   encrypted_password    加密之后的密码
  # }
  # Return:
  # 成功：
  # {
  #     flag:1,
  #     tips:'登陆成功',
  #     content:{},
  #     time:'2014-01-01 10:20:10'
  # }
  # 失败：
  # {
  #     flag:0,
  #     tips:'用户名或密码错误',
  #     content:{},
  #     time:'2014-01-01 10:20:10'
  # }

  def login_in
    params= consultant_user_params
    user = ConsultantUser.where({ phone:params[:phone],encrypted_password:params[:encrypted_password] }).first
    if user.present?
        user.login
        render_success_json('登陆成功',{'uid'=>user.uid,'token'=>user.token})
    else
      render_failure_json('用户名或密码错误')
    end
  end

  #顾问退出登陆的接口
  #URL:consultant_user/sign_out
  #Methon:Post
  #Params：{
  #   token                 token
  # }
  #Return:
  # {
  #     flag:1,
  #     tips:'退出成功',
  #     content:{},
  #     time:'2014-01-01 10:20:10'
  # }
  def sign_out
    if @current_user
      @current_user.token = nil
      @current_user.save
    end
    render_success_json('退出成功')
  end

  #获取顾问信息的接口
  #URL:consultant_user/get_consultant_user_info
  #Methon:Post
  #Params：{
  #   token                 token
  # }
  #Return:
  # {
  #     flag:1,
  #     tips:'用户信息',
  #     content:{
  #       内容待定
  #     },
  #     time:'2014-01-01 10:20:10'
  # }
  def get_consultant_user_info
    render_success_json('用户信息',@current_user.to_json)
  end

  private

  def consultant_user_params(method='post')
    if method.blank? or (method.to_s.downcase=="get" and request.get?) or (method.to_s.downcase=="post" and request.post?)
      params.permit(:email, :phone, :token, :name, :encrypted_password, :invitation_code, :is_public,:institution_name,:education_id, :professional_id, :country_id)
    else
      render_access_denied_json('请求路径错误')
    end
  end

end
