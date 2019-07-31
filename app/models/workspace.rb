class Workspace < ApplicationRecord
    has_many :users_workspaces, dependent: :destroy
    has_many :users, through: :users_workspaces
    has_many :groups, dependent: :destroy
  
end
