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
end
