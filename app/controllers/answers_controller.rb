#encoding : utf-8
class AnswersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index

  end

  def create
    ans = Answer.new
    ans.title = params[:title]
    ans.question_id = params[:question_id]
    ans.object_id = params[:user_id]
    ans.consultant = params[:consultant]
    ans.parent_id = params[:parent_id] if params[:parent_id].present?
    if ans.save
      render :json => {:result => "1"}
    else
      render :json => {:result => "0", message: '回复失败！'}
    end
  end
end
