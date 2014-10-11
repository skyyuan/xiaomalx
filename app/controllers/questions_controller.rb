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

  def question_count
    tag
    que_ids = @question_tags.map &:question_id
    answers_count = Question.where(id: que_ids).sum('answer_count')
    render :json => {question_count: @question_tags.count, answers_count: answers_count}
  end

  def questions_tags
    tag
    que_ids = @question_tags.map &:question_id
    questions = Question.where(id: que_ids)
    if params[:new].present?
      questions = questions.order("created_at desc")
    end
    if params[:hot].present?
      questions = questions.order("answer_count desc")
    end
    render :json => questions and return
  end

  def hot_tag
    category = Category.find(params[:tag_id])
    categories = Category.where("parent_id is not null and parent_id <> ? and parent_id <> ?",category.parent.id,params[:tag_id])
    # json_data = {}
    # categories.each do |cat|
    #   if !cat.parent.parent.present?
    #     json_data.merge!(cat.id => cat.name)
    #   end
    # end
    # render :json => json_data
    render :json => categories
  end

  def question_answers
    answers = Answer.where(question_id: params[:question_id])
    render :json => answers
  end

  def tag
    category = Category.find(params[:tag_id])
    if category.parent.name == 'level'
      @question_tags = QuestionTag.where(level_id: params[:tag_id])
    elsif category.parent.name == 'country'
      @question_tags = QuestionTag.where(country_id: params[:tag_id])
    elsif category.parent.name == 'other'
      @question_tags = QuestionTag.where(other_id: params[:tag_id])
    else
      @question_tags = QuestionTag.where(profe_id: params[:tag_id])
    end
  end
end
