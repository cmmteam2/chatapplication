class Groupmessage < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :groupthreadmessages, dependent: :destroy
end
