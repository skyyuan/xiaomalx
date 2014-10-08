class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :elder
  has_one :question_tag
  has_many :answers
end
