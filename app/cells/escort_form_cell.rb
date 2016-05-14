# rubocop:disable ClassLength
class EscortFormCell < FormCell
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

  # rubocop:disable MethodLength
  def toggle_container(form, name, i18n_scope, &_blk)
    content_tag(
      :fieldset,
      class: 'js_has_optional_section',
      id: "#{form.object.name}_#{name}"
    ) do
      join(
        title_text(name, i18n_scope),
        hint_text { t("#{i18n_scope}.#{name}.help_text") },
        form_group_container(form, name, id: '') {
          join(
            clearable_radio_buttons(form, name, i18n_scope),
            content_tag(:div) { yield }
          )
        }
      )
    end
  end # rubocop:enable MethodLength

  def text_toggle_container(form, name, i18n_scope, &_blk)
    toggle_container(form, name, i18n_scope) do
      form_group_container(
        form, :"#{name}_details", classes: 'optional-section') { yield }
    end
  end

  def details_text_area_with_help_text(form, name, i18n_scope)
    join(
      details_help_text(form, name, i18n_scope),
      details_guidance_text(name, i18n_scope),
      details_text_area(form, name)
    )
  end

  def title_text(name, i18n_scope)
    content_tag(:legend, class: 'form-label-bold') {
      content_tag(:span) { t("#{i18n_scope}.#{name}.title") }
    }
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

  def radio_label(form, value)
    form.label :sex, value: value, class: 'block-label' do
      join(
        t(".prisoner.sex.#{value}_label"),
        form.radio_button(:sex, value)
      )
    end
  end

  def checkbox_label(form, field)
    form.label field, class: 'block-label inline' do
      join(
        form.check_box(field),
        t(".healthcare.#{field}")
      )
    end
  end

  def offence_checkbox_label(fields, field)
    fields.label field, class: 'offences-block-label' do
      join(
        content_tag(:div, class: 'input-wrapper') { fields.check_box(field) },
        content_tag(:div, class: 'offence-checkbox-label') {
          t(".offences.offence_details.#{field}")
        }
      )
    end
  end
end # rubocop:enable ClassLength
