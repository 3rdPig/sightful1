class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :address
  has_many :works
  has_many :educations
  has_many :availabilities
  has_many :fields

  has_many :followers , through: :follower_follows , source: :follower
  has_many :follower_follows , foreign_key: :followee_id , class_name: 'Follow'

  has_many :followees , through: :followee_follows , source: :followee
  has_many :followee_follows , foreign_key: :follower_id , class_name: 'Follow'

  has_many :invitations , foreign_key: :invitee , class_name: 'Schedule'

  
  has_many :sent_requests , foreign_key: 'host_id' , class_name: 'Schedule'


  has_many :user_schedules
  has_many :schedules , through: :user_schedules

  has_many :notifications
  
  has_many :posts
  has_many :comments

  before_create :confirmation_token
  after_create :signup_confirmation_email
  
  include BCrypt

  def pwd
    @password ||= Password.new(password)
  end

  def pwd=(new_password)
    @password = Password.create(new_password)
    self.password = @password
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end
  
  def signup_confirmation_email
    # configure raise exception on/off in development.rb
    # Currently we are using mailgun sandbox. Emails not in the authorized list can't receive confirmation mail.
    UserMailer.signup_confirmation(self).deliver_later
  end
end