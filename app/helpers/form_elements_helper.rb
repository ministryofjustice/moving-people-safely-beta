module FormElementsHelper
  def date_fields(form, name, &blk)
    error_container(form, name) {
      capture(&blk)
    }
  end

  def error_container(form, name, options = { class: 'form-date group' }, &blk)
    html_class = [options[:class]]
    if form.object.errors.include?(name)
      html_class << ' error'
    end
    content_tag(
      :div,
      class: html_class,
      id: "#{form.object.name}_#{name}",
      &blk
    )
  end
end
