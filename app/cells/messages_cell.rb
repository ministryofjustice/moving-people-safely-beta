class MessagesCell < BaseCell
  def flash_error
    parent_controller.flash.now[:error]
  end

  def flash_succes
    parent_controller.flash.now[:success]
  end

  def links_to_errors
    model.errors.map do |attribute|
      content_tag :li do
        link_to_field_with_error(attribute)
      end
    end
  end

  def link_to_field_with_error(attribute)
    # For "details" text areas we want the link to point to the
    # container div so that the user can have some context regarding
    # the error (the conatiner will contain the name heading) so we
    # need to remove the "_details" part as the convention in the
    # text toggle attributes(where this tends to be an issue) is to
    # have an attribute and an accompanying attribute_details too.
    field = attribute.to_s.gsub(/_details\Z/, '')
    model_class = model.class.name.underscore.gsub(/_form\Z/, '')

    link_to(
      model.errors.full_messages_for(attribute).first,
      "##{model_class}_#{field}"
    )
  end

  def show
    if model.errors.any?
      render :errors
    elsif flash_succes.present?
      render :success
    end
  end
end
