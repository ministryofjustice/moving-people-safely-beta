class PresentOrFutureDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, date)
    if date.is_a?(Date) && date.past?
      record.errors.add(attribute, :in_the_past)
    end
  end
end
