class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception




  #顾问用户登陆的验证
  #整个生命周期中返回值得Flag为1001，都表示未登陆，
  # Return:
  # {
  #     flag:1001,
  #     tips:'用户未登陆',
  #     content:{},
  #     time:'2014-01-01 10:20:10'
  # }
  def authorize_consultant_user
    if !current_consultant_user
      render_overdue_json('用户未登陆')
    end
  end

  def current_consultant_user
    ConsultantUser.current = @current_user ||= ConsultantUser.where({token:params['token']}).first  unless params['token'].blank?
  end

end
