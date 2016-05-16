# rubocop:disable ClassLength
class EscortFormCell < FormCell
  def single_field(form, field)
    form_group_container(field) do
      join(
        form.label(field, class: 'form-label-bold', for: field),
        form.text_field(field, class: 'string form-control', id: field)
      )
    end
  end

  def form_group_container(field, classes: '', id: nil, &_blk)
    content_tag(
      :div,
      class: html_classes(field, classes),
      id: id || "#{model.name}_#{field}"
    ) { yield }
  end

  def hint_text(&_blk)
    content_tag(:p, class: 'form-hint') { yield }
  end

  def join(*strings)
    strings.flatten.inject(ActiveSupport::SafeBuffer.new, &:<<)
  end

  def html_classes(field, html_class)
    html_classes = ['form-group', html_class]
    html_classes << 'error' if model.errors.include?(field)
    html_classes.join(' ')
  end

  # rubocop:disable MethodLength
  def toggle_container(form, name, &_blk)
    content_tag(
      :fieldset,
      class: 'js_has_optional_section',
      id: "#{model.name}_#{name}"
    ) do
      join(
        title_text(name),
        hint_text { t(".#{model.name}.#{name}.help_text") },
        form_group_container(name, id: '') {
          join(
            clearable_radio_buttons(form, name),
            content_tag(:div) { yield }
          )
        }
      )
    end
  end # rubocop:enable MethodLength

  def text_toggle_container(form, name, &_blk)
    toggle_container(form, name) do
      form_group_container(
        :"#{name}_details", classes: 'optional-section') { yield }
    end
  end

  def details_text_area_with_help_text(form, name)
    join(
      details_help_text(form, name),
      details_guidance_text(name),
      details_text_area(form, name)
    )
  end

  def title_text(name)
    content_tag(:legend, class: 'form-label-bold') {
      content_tag(:span) { t(".#{model.name}.#{name}.title") }
    }
  end

  def clearable_radio_buttons(form, name)
    join(
      yes_no_radio_buttons(form, name),
      clear_selection_radio_button(form, name)
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

  def clear_selection_radio_button(form, name)
    join(
      form.radio_button(name, 'unknown', class: 'visuallyhidden'),
      form.label(
        "#{name}_unknown",
        t(".#{model.name}.labels.clear"),
        class: 'unknown_value'
      )
    )
  end

  def details_text_area(form, name)
    form.text_area(
      "#{name}_details",
      autocomplete: 'off',
      class: 'form-control',
      id: "#{model.name}_#{name}_details"
    )
  end

  def details_help_text(form, name)
    form.label(
      "#{name}_details",
      t(".#{model.name}.#{name}.details_help_text")
    )
  end

  def details_guidance_text(name)
    # Guidance text does not necessarily apply to every textarea &
    # can be blank theefore we check its existence
    i18n_path = ".#{model.name}.#{name}.details_guidance_text"
    hint_text { t(i18n_path) } if I18n.exists?(i18n_path, I18n.locale)
  end

  def radio_label(form, field, value)
    form.label field, value: value, class: 'block-label' do
      join(
        t(".#{model.name}.#{field}.#{value}_label"),
        form.radio_button(field, value)
      )
    end
  end

  def checkbox_label(form, field)
    form.label field, class: 'block-label inline' do
      join(
        form.check_box(field),
        t(".#{model.name}.#{field}")
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
