class Point < ApplicationRecord
  belongs_to :category
  has_many :images, dependent: :destroy

  scope :by_name, -> { order(:name) }

  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
end
