class CategoryImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave

    process convert: "png"
    process tags: ["category_picture"]
  else
    include CarrierWave::MiniMagick

    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [32, 32]
end
