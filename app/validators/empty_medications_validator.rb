class EmptyMedicationsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, medication_forms)
    filled_medications = medication_forms.reject(&:empty?).reject(&:_destroy)

    if record.medication && filled_medications.none?
      record.errors.add(attribute, :empty)
    end
  end
end
