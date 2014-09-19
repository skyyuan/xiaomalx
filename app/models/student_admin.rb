class StudentAdmin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :students, :dependent => :destroy
  # attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  attr_accessible :email, :password, :password_confirmation, :remember_me#, :role_id
end
