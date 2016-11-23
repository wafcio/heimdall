class Category < ApplicationRecord
  acts_as_nested_set

  mount_uploader :image, CategoryImageUploader

  scope :sort_by_name, -> { order(:name) }

  validates :name, presence: true
end
