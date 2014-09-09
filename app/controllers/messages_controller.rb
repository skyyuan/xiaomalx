#encoding : utf-8
class MessagesController < ApplicationController
  def index
    @message_count = Message.where(student_id: params[:student_id], is_check: 0).group("state").order('is_check asc').count
    msg_content = []
    date_time = []
    (1..4).each do |i|
      message = Message.where(state: i).order('is_check asc').order("created_at desc")
      msg_content << [i,message.first.msg_content]
      date_time << [i,message.first.created_at.strftime('%m-%d')]
    end
    respond_to do |format|
      format.json { render json: {count: @message_count, message: msg_content, date_time: date_time} }
    end
  end

  def state_all
    @message = Message.where(state: params[:state]).order('created_at desc').page(params[:page]).pre(10)
    message = Message.where(state: params[:state], student_id: params[:student_id]).update_all(is_check: 1)
    respond_to do |format|
      format.json { render json: @message }
    end
  end
end
