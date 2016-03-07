module ApplicationHelper
  def error_wrapper(form, styles:, styles_on_error:, &_blk)
    if form.object.errors.any?
      styles = [styles, styles_on_error].join(' ')
    end
    content_tag(:div, class: styles) { yield }
  end
end
