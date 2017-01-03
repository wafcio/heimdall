class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :point
end
