class QuestionSerializer < ActiveModel::Serializer
  attributes :title, :name, :created_at, :preview, :answer_count, :tags
  def name
    {object.elder.id => object.elder.nickname}
  end

  def tags
    tag = object.question_tag
    data_json = {}
    level = Category.find(tag.level_id)
    country = Category.find(tag.country_id)
    profe = Category.find(tag.profe_id)
    other = Category.find(tag.other_id)
    data_json.merge!(level.id => level.name,
                    country.id => country.name,
                    profe.parent.id => profe.parent.name,
                    other.id => other.name)
    data_json
  end
end
