#encoding : utf-8
class QuestionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    questions = Question.all
    if params[:new].present?
      questions = questions.order("recommend desc").order("created_at desc")
    end
    if params[:hot].present?
      questions = questions.order("answer_count desc")
    end
    questions = questions.page(params[:page]).per(params[:page_per])
    render :json => questions and return
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
        tag.profe_children_id = params[:profe_children_id] if params[:profe_children_id].present?
        tag.other_id = params[:other_id]
        tag.save
      end
      render :json => {:result => "1"}
    else
      render :json => {:result => "0", message: '用户已退出登陆！'}
    end
  end

  def questions_tags
    questions = Question
    if params[:level_id].present?
      questions = questions.where(level_id: params[:level_id])
    end
    if params[:country_id].present?
      questions = questions.where(country_id: params[:country_id])
    end
    if params[:profe_children_id].present?
    else
      if params[:profe_id].present?
      end
    end

    render :json => questions and return
  end

  def question_answers
    answers = Answer.where(question_id: params[:question_id])
    question = Question.find params[:question_id]
    question.preview = question.preview.to_i + 1
    question.save
    render :json => answers
  end
end
