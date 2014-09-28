#encoding : utf-8
class ConsultantUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessible :email, :phone, :token, :name, :encrypted_password, :invitation_code, :is_public,
                  :education_id, :professional_id, :country_id,:institution_name

  validates_presence_of   :phone,:message => "手机不能为空"
  validates_uniqueness_of :phone, :message => "该手机已经注册"
  validates_presence_of   :name,:message => "昵称/姓名不能为空"
  validates_presence_of   :encrypted_password,:message => "密码不能为空"
  validates_presence_of   :invitation_code,:message => "邀请码不能为空"
  validates_presence_of   :education_id,:message => "擅长学历不能为空"
  validates_presence_of   :professional_id,:message => "擅长专业不能为空"
  validates_presence_of   :country_id,:message => "擅长国家不能为空"

  before_create :set_auth_token

  def login
      if self.token.blank?
        self.token = generate_auth_token
        self.save
      end
  end

  def self.current=(user)
    @current_user = user
  end

  def self.current
    @current_user
  end

  private

  def set_auth_token
    return if self.token.present?
    self.token = generate_auth_token
  end

  def generate_auth_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(token: token)
    end
  end

end
