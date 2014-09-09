#encoding: utf-8
require 'jpush_api_ruby_client'
class Curriculum < ActiveRecord::Base

  after_save :arrival_school_push
  after_save :leave_school_push

  belongs_to :student, :foreign_key => 'student_id'

  attr_accessible :course_content, :course_date, :course_title, :student_id, :arrival_school, :leave_school
  has_many :individual_lessons, :foreign_key => 'curriculum_id', :dependent => :destroy
  has_many :supplement_lessons, :foreign_key => 'curriculum_id', :dependent => :destroy

  validates_presence_of :course_date, :message => '日期不能为空！'

  def arrival_school_push
    if self.arrival_school_changed?
      app_key = '3c9a0f7e4e60bb0945bae824'
      master_secret = 'daadba9523d5da95f81edf46'
      push_client = JPushApiRubyClient::Client.new(app_key, master_secret,'platform' => JPushApiRubyClient::PlatformType::BOTH)
      send_no = push_client.generate_send_no
      msg_title = '亲爱的小马家长'
      msg_content = "您的孩子今日到校时间【#{self.arrival_school}】"
      alias_value = self.student.id
      Message.create(curriculum_id: self.id, is_check: 0,state: 2, student_id: self.student_id, msg_content: "您孩子#{selfcourse_date}日到校时间-#{self.arrival_school}!")
      push_client.send_notification_with_tag(send_no, alias_value, msg_title, msg_content)
    end
  end

  def leave_school_push
    if self.leave_school_changed?
      app_key = '3c9a0f7e4e60bb0945bae824'
      master_secret = 'daadba9523d5da95f81edf46'
      push_client = JPushApiRubyClient::Client.new(app_key, master_secret,'platform' => JPushApiRubyClient::PlatformType::BOTH)
      send_no = push_client.generate_send_no
      msg_title = '亲爱的小马家长'
      msg_content = "您的孩子今日离校时间【#{self.leave_school}】"
      alias_value = self.student.id
      Message.create(curriculum_id: self.id, is_check: 0,state: 2, student_id: self.student_id, msg_content: "您孩子#{selfcourse_date}日离校时间-#{self.arrival_school}!")
      push_client.send_notification_with_tag(send_no, alias_value, msg_title, msg_content)
    end
  end

end
