module TextToggleFormElementsHelper
  # rubocop:disable MethodLength
  def text_toggle_container(form, name, i18n_scope, &_blk)
    content_tag(:fieldset, class: 'js_has_optional_section') do
      join(
        title_with_hint(name, i18n_scope),
        form_group_container {
          join(
            clearable_radio_buttons(form, name, i18n_scope),
            form_group_container(classes: 'optional-section') { yield }
          )
        }
      )
    end
  end # rubocop:enable MethodLength

  def details_text_area_with_help_text(form, name, i18n_scope)
    join(
      details_help_text(form, name, i18n_scope),
      details_guidance_text(name, i18n_scope),
      details_text_area(form, name)
    )
  end

  def title_with_hint(name, i18n_scope)
    join(
      content_tag(:legend, class: 'form-label-bold') {
        content_tag(:span) { t("#{i18n_scope}.#{name}.title") }
      },
      hint_text { t("#{i18n_scope}.#{name}.help_text") }
    )
  end

  def clearable_radio_buttons(form, name, i18n_scope)
    join(
      yes_no_radio_buttons(form, name),
      clear_selection_radio_button(form, name, i18n_scope)
    )
  end

  def yes_no_radio_buttons(form, name)
    { true => :yes, false => :no }.map do |(value, translation_key)|
      form.label(name, value: value, class: 'block-label inline') do
        join(
          form.radio_button(name, value),
          t(translation_key)
        )
      end
    end
  end

  def clear_selection_radio_button(form, name, i18n_scope)
    join(
      form.radio_button(name, 'unknown', class: 'visuallyhidden'),
      form.label(
        "#{name}_unknown",
        t("#{i18n_scope}.labels.clear"),
        class: 'unknown_value'
      )
    )
  end

  def details_text_area(form, name)
    form.text_area(
      "#{name}_details",
      autocomplete: 'off',
      class: 'form-control',
      id: "#{form.object.name}_#{name}_details"
    )
  end

  def details_help_text(form, name, i18n_scope)
    form.label(
      "#{name}_details",
      t("#{i18n_scope}.#{name}.details_help_text")
    )
  end

  def details_guidance_text(name, i18n_scope)
    # Guidance text does not necessarily apply to every textarea &
    # can be blank theefore we check its existence
    i18n_path = "#{i18n_scope}.#{name}.details_guidance_text"
    hint_text { t(i18n_path) } if I18n.exists?(i18n_path, I18n.locale)
  end
end
