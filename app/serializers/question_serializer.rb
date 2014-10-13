class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :name, :created_at, :recommend, :preview, :answer_count, :tags
  def name
    {'id' => object.elder.id,
     'name' => object.elder.nickname,
     'photo' => object.elder.photo
    }
  end

  def tags
    tag = object.question_tag
    data_json = {}
    level = Category.find(tag.level_id)
    country = Category.find(tag.country_id)
    profe = Category.find(tag.profe_id)
    profe_children = Category.find(tag.profe_children_id) if tag.profe_children_id
    if profe_children.present?
      children_name = profe_children.name
    else
      children_name = ''
    end
    other = Category.find(tag.other_id)
    data_json.merge!('tag_name' => [level.name,country.name, profe.name, other.name, children_name])
    data_json
  end
end
