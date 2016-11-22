class User < ApplicationRecord
  scope :sort_by_name, -> { order(:name) }

  validates :name, :email, :google_uid, presence: true
  validates :admin, inclusion: { in: [true, false] }
end
