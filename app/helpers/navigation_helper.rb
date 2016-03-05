module NavigationHelper
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
