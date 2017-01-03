# encoding: utf-8

class CategoryImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave

    process convert: "png"
    process tags: ["category_picture"]
  else
    include CarrierWave::MiniMagick

    storage :postgresql_lo
  end

  process resize_to_fill: [32, 32]
end
