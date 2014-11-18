# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  username               :string(255)
#  school                 :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  points                 :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :submissions
  has_many :submitted_problems, through: :submissions, source: :problem

  #Admins
  has_many :set_problems, :foreign_key => 'problem_setter_id', :class_name => 'Problem'

  validates :name, :username, :school, presence: true

  after_initialize :default_values

  private
  def default_values
    self.points ||= 0
    self.role ||= "coder"
  end
end
