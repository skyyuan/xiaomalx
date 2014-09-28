class Elder < ActiveRecord::Base
  has_one :advisory_information
  has_many :questions
end
