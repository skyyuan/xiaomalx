#encoding : utf-8
class AnswerSerializer < ActiveModel::Serializer
  attributes :title, :name, :consultant, :star_level, :praise, :reply, :created_at
  def name
    name = nil
    if object.consultant.to_i == 1
      name = ConsultantUser.find(object.object_id).name
    else
      name = Elder.find(object.object_id).nickname
    end
    name
  end

  def star_level
    ""
  end

  def reply
    reply = ""
    if object.parent.present?
      if object.parent.consultant.to_i == 1
        reply = '回复' + ConsultantUser.find(object.parent.object_id).name + '：' + object.parent.title
      else
        reply = '回复' + Elder.find(object.parent.object_id).nickname + '：' + object.parent.title
      end
    end
    reply
  end
end
