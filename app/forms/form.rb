class Form
  include Core

  extend ActiveModel::Translation

  attr_accessor :model

  def initialize(model)
    @model = model
    load_model_data
  end

  def assign_attributes(params)
    params.each { |key, value| public_send("#{key}=", value) }
  end

  def save
    if valid?
      target.update_attributes(attributes)
      true
    else
      false
    end
  end

  def url
    Rails.application.routes.url_helpers.send("#{name}_path", model)
  end

  def target
    model
  end

private

  def load_model_data
    attributes.each_key { |key| public_send("#{key}=", target.send(key)) }
  end
end
