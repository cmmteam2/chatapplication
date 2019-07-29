class User < ApplicationRecord
    has_secure_password

    has_many :groups_users
    has_many :groups, through: :groups_users
    has_many :users_workspaces
    has_many :groupthreadmessages
    has_many :workspaces, through: :users_workspaces
    paginates_per 3
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
               format: { with: VALID_EMAIL_REGEX },
               uniqueness: { case_sensitive: false }
    validates :name, presence: true, length: { maximum: 50 }
    validates :password, presence: true, length: { minimum: 6 }
end
