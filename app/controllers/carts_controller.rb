# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @current_order = current_order.decorate
  end
end
