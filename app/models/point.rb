class Point < ApplicationRecord
  belongs_to :category

  scope :by_name, -> { order(:name) }

  validates :name, presence: true
end
