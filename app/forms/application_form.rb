# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model

  def initialize(model, params = {})
    self.attributes = params
    @params = params
    @model = model
  end

  def save
    return unless valid?

    @model.update(@params)
    @model
  end
end
