class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :elder
  has_many :question_tags
  has_many :answers
end
