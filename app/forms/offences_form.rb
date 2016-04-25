class OffencesForm < Form
  include Form::TextToggleAttribute

  text_toggle_attribute :not_for_release
  text_toggle_attribute :must_return
  text_toggle_attribute :must_not_return

  attribute :offence_details, Array[OffenceDetailsForm],
    coercer: Form::MultiplesCoercer

  def status_options
    OffenceDetailsForm::STATUS_TYPES.map do |c|
      [I18n.t("offence_details_form.status.#{c}"), c]
    end
  end

private

  def load_model_data
    super
    self.offence_details = target.backfilled_offence_details
  end

  def prepared_attributes_for_model
    attributes.dup.tap do |a|
      a[:offence_details_attributes] =
        a.delete(:offence_details).reject(&:empty?).map(&:attributes)
    end
  end

  def persist
    target.update_attributes(prepared_attributes_for_model)
    reload
  end
end
