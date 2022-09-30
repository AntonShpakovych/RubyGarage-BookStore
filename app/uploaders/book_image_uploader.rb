# frozen_string_literal: true

class BookImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*)
    'default-book.png'
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
