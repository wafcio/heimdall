# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave

    process convert: "jpg"
    process tags: ["picture"]
  else
    include CarrierWave::MiniMagick

    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [1024, 768]

  version :small do
    process resize_to_fill: [150, 150]
  end
end
