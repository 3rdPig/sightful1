class Schedule < ActiveRecord::Base
    belongs_to :invitee , foreign_key: :invitee , class_name: 'User'
    belongs_to :inviter , foreign_key: :inviter , class_name: 'User'
    belongs_to :ref, foreign_key: :ref, class_name: 'Message'
    has_many :user_schedules
    has_many :users , through: :user_schedules
end
