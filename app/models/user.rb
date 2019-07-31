class User < ApplicationRecord
    has_secure_password

    has_many :groups_users, dependent: :destroy
    has_many :groups, through: :groups_users
    has_many :users_workspaces, dependent: :destroy
    has_many :groupthreadmessages, dependent: :destroy
    has_many :workspaces, through: :users_workspaces
    paginates_per 3
    
end
