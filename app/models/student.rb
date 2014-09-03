#encoding: utf-8
class Student < ActiveRecord::Base
  has_many :curriculums, :foreign_key => 'student_id', :dependent => :destroy
  has_many :individual_lessons, :foreign_key => 'student_id', :dependent => :destroy
  has_many :supplement_lessons, :foreign_key => 'student_id', :dependent => :destroy
  has_many :elective_registrations, foreign_key: 'student_id', :dependent => :destroy
  belongs_to :student_admin

  attr_accessible :account, :password, :student_admin_id,:student_name, :student_picture, :school_hour, :school_district, :student_type

  validates_presence_of :student_name, :message => '姓名不能为空', :on => :create
  validates_uniqueness_of :account, :message => '账号已经存在'

end
