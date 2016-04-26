class OffencesForm < Form
  include Form::TextToggleAttribute

  text_toggle_attribute :not_for_release
  text_toggle_attribute :must_return
  text_toggle_attribute :must_not_return

  attribute :offence_details, Array[OffenceDetailsForm]

  def offence_details
    super || []
  end

  def offence_details=(input)
    super(prepare_incoming_offence_details(input))
  end

  def backfilled_offence_details
    target.backfilled_offence_details(offence_details)
  end

  def status_options
    OffenceDetailsForm::STATUS_TYPES.map do |c|
      [I18n.t("offence_details_form.status.#{c}"), c]
    end
  end

private

  def prepare_incoming_offence_details(input)
    input.is_a?(Hash) ? input.values : input.map(&:attributes)
  end

  def prepared_attributes_for_model
    attributes.tap do |a|
      a[:offence_details_attributes] =
        a.delete(:offence_details).reject(&:empty?).map(&:attributes)
    end
  end

  def persist
    target.update_attributes(prepared_attributes_for_model)
    reload
  end
end
