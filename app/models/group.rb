class Group < ApplicationRecord
  belongs_to :workspace
  has_many :groups_users, dependent: :destroy
  has_many :groupmessages , dependent: :destroy
  has_many :users, through: :groups_users
end
