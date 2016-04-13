class InvalidMedicationsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, medication_forms)
    filled_medications = medication_forms.reject(&:empty?).reject(&:_destroy)

    if record.medication && filled_medications.any?(&:invalid?)
      record.errors.add(attribute, :no_description)
    end
  end
end
