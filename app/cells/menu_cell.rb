class MenuCell < BaseCell
  def link_to_quick_actions_preview
    link_to t('quick_actions.preview'), pdf_path(model)
  end

  def link_to_quick_actions_find_prisoner
    link_to t('quick_actions.find_prisoner'), root_path
  end

  def navigation_item(text, path)
    content_tag(:li, link_or_text(text, path), class: apply_current_class(path))
  end

  def apply_current_class(path)
    'current' if current_page?(path)
  end

  def link_or_text(text, path)
    current_page?(path) ? text : link_to(text, path)
  end

  def current_page?(path)
    path == request.env['PATH_INFO']
  end

  SECTIONS = ['summary', Form::Routing.form_names].flatten

  def navigation_list
    SECTIONS.each_with_object(ActiveSupport::SafeBuffer.new) do |name, buf|
      buf << navigation_item(t("navigation.#{name}"), send("#{name}_path"))
    end
  end
end
