module FormElementsHelper
  def date_fields(form, field, &_blk)
    form_group_container(form, field, classes: 'form-date') { yield }
  end

  def single_field(form, field)
    form_group_container(form, field) do
      join(
        form.label(field, class: 'form-label-bold', for: field),
        form.text_field(field, class: 'string form-control', id: field)
      )
    end
  end

  def form_group_container(form, field, classes: '', id: nil, &_blk)
    content_tag(
      :div,
      class: html_classes(form, field, classes),
      id: id || "#{form.object.name}_#{field}"
    ) { yield }
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
