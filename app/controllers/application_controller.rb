# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :all_category

  def all_category
    @all_category ||= Category.all
  end
end
