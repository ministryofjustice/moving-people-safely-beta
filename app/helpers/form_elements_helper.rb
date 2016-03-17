module FormElementsHelper
  def date_fields(form, field)
    error_container(form, field, 'form-date') do
      yield
    end
  end

  def single_field(form, field)
    error_container(form, field) do
      form.label(field, class: 'form-label-bold', for: field) +
        form.text_field(field, class: 'string form-control', id: field)
    end
  end

  def error_container(form, field, html_class = nil)
    content_tag(
      :div,
      class: html_classes(form, field, html_class),
      id: "#{form.object.name}_#{field}"
    ) { yield }
  end

  def form_group_container(classes:'', &_blk)
    styles = ['form-group', classes].join(' ')
    content_tag(:div, class: styles) { yield }
  end

  def hint_text(&_blk)
    content_tag(:p, class: 'form-hint') { yield }
  end

  def join(*strings)
    strings.flatten.inject(ActiveSupport::SafeBuffer.new, &:<<)
  end

  def html_classes(form, field, html_class)
    html_classes = ['form-group', html_class]
    html_classes << 'error' if form.object.errors.include?(field)
    html_classes.join(' ')
  end
end
