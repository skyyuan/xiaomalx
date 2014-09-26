#encoding : utf-8
class AdvisoryInformationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    if params[:user_id]
      advisory_info = AdvisoryInformation.new
      advisory_info.destination = params[:destination]
      advisory_info.education = params[:education]
      advisory_info.professional = params[:professional]
      advisory_info.funds = params[:funds]
      advisory_info.school = params[:school]
      advisory_info.studying_professional = params[:studying_professional]
      advisory_info.gpa = params[:gpa]
      advisory_info.text_type = params[:text_type]
      advisory_info.results = params[:results]
      advisory_info.ranking = params[:ranking]
      advisory_info.employment = params[:employment]
      advisory_info.resettlement = params[:resettlement]
      advisory_info.elder_id = params[:user_id]
      respond_to do |format|
        if advisory_info.save
          format.json { render json: {result: 1 } }
        else
          format.json { render json: {result: 0, message: advisory_info.errors } }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {result: 0, message: "用户已退出登陆！"} }
      end
    end
  end

  def show
    advisory_info = AdvisoryInformation.find_by_elder_id(params[:id])
    respond_to do |format|
      format.json { render json: advisory_info } if advisory_info.present?
      format.json { render json: {result: 0, message: "您还没有填写信息！" } } if !advisory_info.present?
    end
  end
end
