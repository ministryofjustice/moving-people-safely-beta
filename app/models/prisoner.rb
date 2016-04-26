class Prisoner < ActiveRecord::Base
  has_paper_trail
  belongs_to :escort, touch: true

  def full_name
    [family_name, forenames].reject(&:blank?).join(', ')
  end

  def formatted_date_of_birth
    if date_of_birth.present?
      date_of_birth.to_s(:slashed_day_month_year)
    end
  end

  def capitalized_sex
    if sex.present?
      sex.chr.capitalize
    end
  end

  def age
    if date_of_birth.present?
      AgeCalculator.age(date_of_birth)
    end
  end

  MAX_ALIASES = 10
  EMPTY_STRING = ''

  def backfilled_aliases
    BackfillCollection.call(aliases) { EMPTY_STRING }.take(MAX_ALIASES)
  end
end
