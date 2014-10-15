class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :name, :created_at, :recommend, :preview, :answer_count, :tags
  def name
    {'id' => object.elder.id,
     'name' => object.elder.nickname,
     'photo' => object.elder.photo
    }
  end

  def created_at
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def tags
    tag = object.question_tag
    data_json = {}
    level = Category.find(tag.level_id) if tag.level_id.present?
    level_name = level.present? ? level.name : ''

    country = Category.find(tag.country_id) if tag.country_id.present?
    country_name = country.present? ? country.name : ''

    profe = Category.find(tag.profe_id) if tag.profe_id.present?
    profe_name = profe.present? ? profe.name : ''

    profe_children = Category.find(tag.profe_children_id) if tag.profe_children_id.present?
    children_name = profe_children.present? ? profe_children.name : ''

    other = Category.find(tag.other_id) if tag.other_id.present?
    other_name = other.present? ? other.name : ''

    data_json.merge!('tag_name' => [level_name,country_name, profe_name, other_name, children_name])
    data_json
  end
end
