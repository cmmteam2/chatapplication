class Workspace < ApplicationRecord
    has_many :users_workspaces, dependent: :destroy
    has_many :users, through: :users_workspaces
    has_many :groups, dependent: :destroy
    validates :name, presence: true, length: { maximum: 50 }
  
end
