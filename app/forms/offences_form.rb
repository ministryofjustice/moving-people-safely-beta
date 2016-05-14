class OffencesForm < Form
  include Form::TextToggleAttribute

  text_toggle_attribute :not_for_release
  text_toggle_attribute :must_return
  text_toggle_attribute :must_not_return

  attribute :offence_details, Array[OffenceDetailsForm],
    coercer: Form::MultiplesCoercer

  def status_options
    OffenceDetailsForm::STATUS_TYPES.map do |c|
      [I18n.t("escort_form.offences.offence_details_form.status.#{c}"), c]
    end
  end

private

  def load_model_data
    super
    self.offence_details = target.backfilled_offence_details
  end

  def persist
    transformed_attributes = TransformAttributes.new(attributes).call
    target.update_attributes(transformed_attributes)
    reload
  end
end
