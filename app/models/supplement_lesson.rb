#encoding: utf-8
require 'jpush_api_ruby_client'
class SupplementLesson < ActiveRecord::Base
  after_save :student_score_push
  belongs_to :student, :foreign_key => 'student_id'
  attr_accessible :class_room, :course_name, :lesson_date, :lesson_duration, :lesson_name, :lesson_venue, :student_id, :student_score, :student_admin_id, :teacher_name, :curriculum_id
  belongs_to :curriculum, :foreign_key => 'curriculum_id'

  def student_score_push
    if self.student_score_changed?
      app_key = '3c9a0f7e4e60bb0945bae824'
      master_secret = 'daadba9523d5da95f81edf46'
      push_client = JPushApiRubyClient::Client.new(app_key, master_secret,'platform' => JPushApiRubyClient::PlatformType::BOTH)
      send_no = push_client.generate_send_no
      msg_title = '亲爱的小马家长'
      msg_content = "您的孩子今天的辅课成绩已经更新！"
      alias_value = self.student.id
      Message.create(curriculum_id: self.curriculum_id, is_check: 0,state: 4, student_id: self.student_id, msg_content: "您孩子#{self.lesson_date}日的辅课成绩已更新！")
      push_client.send_notification_with_tag(send_no, alias_value, msg_title, msg_content)
    end
  end
end
