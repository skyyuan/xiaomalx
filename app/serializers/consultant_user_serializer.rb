class ConsultantUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo, :institution_name, :education_id, :professional_id, :country_id, :user_reply_count

  def user_reply_count
    Answer.where(object_id: object.id, consultant: 1).count
  end

end
