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
      question = Question.find params[:question_id]
      question.answer_count = question.answer_count.to_i + 1
      question.save
      json_data = []
      name = ''
      if ans.consultant.to_i == 1
        name = ConsultantUser.find(ans.object_id).name
      else
        name = Elder.find(ans.object_id).nickname
      end
      praise = Praise.find_by(answer_id: ans.id, user_id: ans.object_id, consultant: ans.consultant)
      is_praise = 0
      if praise.present?
        is_praise = 1
      end
      reply = ""
      if ans.parent.present?
        if ans.parent.consultant.to_i == 1
          reply = '回复' + ConsultantUser.find(ans.parent.object_id).name + '：' + ans.parent.title
        else
          reply = '回复' + Elder.find(ans.parent.object_id).nickname + '：' + ans.parent.title
        end
      end

      json_data << {'id'=> ans.id ,'title' => ans.title, 'name' => name, 'user_id' => ans.object_id,
        'consultant' => ans.consultant, 'star_level' => 0, 'is_praise' => is_praise,
        'praise' => ans.praises.count, 'reply' => reply, 'created_at' => ans.created_at.strftime("%Y-%m-%d %H:%M:%S"), 'now' => Time.now.strftime("%Y-%m-%d %H:%M:%S")}

      render :json => {:result => "1", question: json_data}
    else
      render :json => {:result => "0", message: '回复失败！'}
    end
  end

  def destroy
    ans = Answer.find params[:id]
    if ans.destroy
      render :json => {:result => "1"}
    else
      render :json => {:result => "0", message: '删除失败！'}
    end
  end
end
