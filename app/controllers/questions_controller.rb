#encoding : utf-8
class QuestionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    question = Question
    if params[:new].present?
      question = question.order("created_at desc")
    end
    if params[:hot].present?
      question = question.order("answer_count desc")
    end
    render :json => question and return
  end

  def create
    if params[:user_id].present?
      question = Question.new
      question.title = params[:title]
      question.elder_id = params[:user_id]
      if question.save
        tag = QuestionTag.new
        tag.question_id = question.id
        tag.level_id = params[:level_id]
        tag.country_id = params[:country_id]
        tag.profe_id = params[:profe_id]
        tag.other_id = params[:other_id]
        tag.save
      end
      render :json => {:result => "1"}
    else
      render :json => {:result => "0", message: '用户已退出登陆！'}
    end
  end
end
