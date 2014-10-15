#encoding : utf-8
class PraisesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    praise = Praise.new
    praise.answer_id = params[:answer_id]
    praise.user_id = params[:user_id]
    praise.consultant = params[:consultant]
    if praise.save
      count = Praise.where(answer_id: params[:answer_id]).count
      render :json => {:result => "1", count: count}
    else
      render :json => {:result => "0", :message => '赞失败'}
    end
  end

  def del_praise
    praise = Praise.find_by(answer_id: params[:answer_id], user_id: params[:user_id], consultant: params[:consultant])
    if praise.present?
      if praise.destroy
        count = Praise.where(answer_id: params[:answer_id]).count
        render :json => {:result => "1", count: count}
      end
    else
      render :json => {:result => "0", :message => "已取消赞" }
    end
  end
end
