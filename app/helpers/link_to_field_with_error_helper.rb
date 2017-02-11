module LinkToFieldWithErrorHelper
  def link_to_field_with_error(object, attribute)
    # For "details" text areas we want the link to point to the
    # container div so that the user can have some context regarding
    # the error (the conatiner will contain the name heading) so we
    # need to remove the "_details" part as the convention in the
    # text toggle attributes(where this tends to be an issue) is to
    # have an attribute and an accompanying attribute_details too.
    field = attribute.to_s.gsub(/_details\Z/, '')

    model = object.class.name.underscore.gsub(/_form/, '')

    link_to(
      object.errors.full_messages_for(attribute).first,
      "##{model}_#{field}"
    )
  end
end
