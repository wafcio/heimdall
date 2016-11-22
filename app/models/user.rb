class User < ApplicationRecord
  validates :name, :email, :google_uid, presence: true
end
