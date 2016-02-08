class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, date)
    record.errors.add(attribute) if date.is_a?(DateHashParser::InvalidDate)
  end
end
