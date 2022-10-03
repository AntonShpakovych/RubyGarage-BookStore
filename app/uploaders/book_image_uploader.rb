# frozen_string_literal: true

class BookImageUploader < ApplicationUploader
  DEFAULT_IMAGE_URL = 'default-book.png'
  DEFAULT_EXTENSION_ALLOW_LIST = %w[jpg jpeg gif png].freeze

  def default_url(*)
    DEFAULT_IMAGE_URL
  end

  def extension_allowlist
    DEFAULT_EXTENSION_ALLOW_LIST
  end
end
