class Prisoner < ActiveRecord::Base
  has_paper_trail
  belongs_to :escort, touch: true

  def full_name
    [family_name, forenames].join(', ')
  end

  def formatted_date_of_birth
    if date_of_birth.present?
      date_of_birth.strftime('%d/%m/%Y')
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
end
