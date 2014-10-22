#encoding : utf-8
class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
  end

  def login
    if params[:open_id].present?
      user = Elder.find_by_open_id(params[:open_id])
      if !user.present?
        user = Elder.new
        user.open_id = params[:open_id]
        user.nickname = params[:nickname]
        user.save
      end
    else
      elders = Elder.where(phone: params[:phone], password: params[:password])
      user = elders.first if elders.present?
    end
    is_advisory_informations = 0
    if user.present?
      is_advisory_informations = AdvisoryInformation.where(elder_id: user.id).count
    end
    respond_to do |format|
      format.json { render json: {result: 1, user: user, is_advisory: is_advisory_informations} } if user.present?
      format.json { render json: {result: 0, message: "您输入的帐号密码有误, 请重新输入！"} } if !user.present?
    end
  end

  def register
    user = Elder.find_by_phone(params[:phone])
    if user.present?
      respond_to do |format|
        format.json { render json: {result: 0, message: "该手机号已经注册过啦！"} }
      end
    else
      user = Elder.new
      user.nickname = params[:nickname]
      user.phone = params[:phone]
      user.password = params[:password]
      respond_to do |format|
        if user.save
          format.json { render json: {result: 1, message: "注册成功！", user: user } }
        else
          format.json { render json: {result: 0, message: "注册失败！", error: user.errors } }
        end
      end
    end
  end

  def verify_phone
    user = Elder.find_by_phone(params[:phone])
    if user.present?
      sms = UserSms.captcha_sms(user)
      respond_to do |format|
        smscode = JSON.parse(sms)
        format.json { render json: {result: 1, smscode: smscode['statusCode'] } }
      end
    else
      respond_to do |format|
        format.json { render json: {result: 0, error: "手机号不存在" } }
      end
    end
  end

  def forgot
    user = Elder.find_by_phone(params[:phone])
    if user.present?
      user.password = params[:password]
      user.save
      respond_to do |format|
        format.json { render json: {result: 1, message: "修改成功，请返回登陆！"} }
      end
    else
      respond_to do |format|
        format.json { render json: {result: 0, message: "该手机号不存在！"} }
      end
    end
  end
end
