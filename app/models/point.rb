class Point < ApplicationRecord
  belongs_to :category
  has_many :images

  scope :by_name, -> { order(:name) }

  validates :name, presence: true
end
