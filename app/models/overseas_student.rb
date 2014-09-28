class OverseasStudent < ActiveRecord::Base

  attr_accessible :code, :name, :phone,:relationship, :contact_name, :contact_phone,:background,
                  :student_status,:comment, :fllow_up_status,:creator_id

  validates_presence_of :name, :message => '学员姓名不能为空'
  validates_presence_of :phone, :message => '学员电话不能为空'
  validates_uniqueness_of :phone, :message => '该学员电话已经存在'

  before_create :set_creator_code

  private
  def set_creator_code
    if self.creator_id.blank?
      self.creator_id = ConsultantUser.current.uid
    end
    if self.code.blank?
      time = nil
      if self.created_at.blank?
        time = Time.now.to_date
      else
        time = self.created_at.to_date
      end
      self.code = OverseasStudent.where({ created_at:(time.beginning_of_day())..(time.end_of_day()) }).maximum(:code).to_i+1
    end
  end

end
