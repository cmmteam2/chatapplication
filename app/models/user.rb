class User < ApplicationRecord
    has_secure_password

    has_many :groups_users
    has_many :groups, through: :groups_users
    has_many :users_workspaces
    has_many :groupthreadmessages
    has_many :workspaces, through: :users_workspaces
    paginates_per 3
end
