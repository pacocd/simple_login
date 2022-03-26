class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, presence: true
end
