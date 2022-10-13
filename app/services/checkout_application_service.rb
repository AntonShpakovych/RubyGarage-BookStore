# frozen_string_literal: true

class CheckoutApplicationService
  def initialize(current_user, current_order, params)
    @user = current_user
    @order = current_order
    @params = params
  end
end
