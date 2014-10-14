#encoding : utf-8
class PraisesController < ApplicationController
  def create
    praise = Praise.new
    praise.answer_id = params[:answer_id]
    praise.user_id = params[:user_id]
    if praise.save
      render :json => {:result => "1"}
    else
      render :json => {:result => "0", :message => '赞失败'}
    end
  end

  def del_praise
    praise = Praise.find_by(answer_id: params[:answer_id], user_id: params[:user_id])
    if praise.present?
      if praise.destroy
        render :json => {:result => "1"}
      end
    else
      render :json => {:result => "0", :message => "已取消赞" }
    end
  end
end
