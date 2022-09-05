# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :categories

  def categories
    @categories ||= Category.all
  end
end
