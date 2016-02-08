class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, decorated_date)
    record.errors.add(attribute) unless decorated_date.valid?
  end
end
