class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, date)
    if coercion_failed?(date) || illegal_year?(date)
      record.errors.add(attribute)
    end
  end

private

  def coercion_failed?(date)
    date.is_a?(Hash)
  end

  def illegal_year?(date)
    date.is_a?(Date) && date.year < 1_000
  end
end
