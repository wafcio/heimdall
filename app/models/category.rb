class Category < ApplicationRecord
  acts_as_nested_set

  mount_uploader :image, CategoryImageUploader

  has_many :points, dependent: :destroy

  scope :sort_by_name, -> { order(:name) }

  validates :name, :image, presence: true
end
