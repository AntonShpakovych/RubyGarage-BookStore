# frozen_string_literal: true

module Helper
  module BookImageDefaultHelper
    VALID_INDEX = -3

    def book_image_default
      BookImageUploader.new.default_url[0...VALID_INDEX]
    end
  end
end
