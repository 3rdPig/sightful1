class Message < ActiveRecord::Base
  has_many :schedule, foreign_key: :ref , class_name: 'Schedule'
end
