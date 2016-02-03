class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute) if value&.invalid?
  end
end
