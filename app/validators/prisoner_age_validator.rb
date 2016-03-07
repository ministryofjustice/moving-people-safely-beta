class PrisonerAgeValidator < ActiveModel::EachValidator
  MIN_AGE = 16
  MAX_AGE = 100

  def validate_each(record, attribute, date)
    if date.is_a?(Date) && outside_age_range?(date)
      record.errors.add(attribute, :out_of_range, min: MIN_AGE, max: MAX_AGE)
    end
  end

private

  def outside_age_range?(date)
    age = AgeCalculator.age(date)
    (MIN_AGE..MAX_AGE).exclude?(age)
  end
end
