class AdvisoryInformationSerializer < ActiveModel::Serializer
  attributes :id, :destination, :education, :professional, :funds, :school, :studying_professional,
  :gpa, :text_type, :results, :ranking, :employment, :resettlement, :ranking, :created_at
end
