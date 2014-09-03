class ElectiveRegistration < ActiveRecord::Base
  attr_accessible :elective_id, :student_id
  validates :student_id, :elective_id, :presence => true
  validates :student_id, :elective_id, :numericality => { :only_integer => true }
  belongs_to :elective, foreign_key: 'elective_id'
  belongs_to :student, foreign_key: 'student_id'
end
