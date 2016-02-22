class Prisoner < ActiveRecord::Base
  has_paper_trail
  belongs_to :escort, touch: true

  def full_name
    [family_name, forenames].join(', ')
  end

  def formatted_date_of_birth
    date_of_birth&.strftime('%d/%m/%Y')
  end

  def capitalized_sex
    sex&.chr&.capitalize
  end

  def age
    if date_of_birth.present?
      AgeCalculator.age(date_of_birth)
    end
  end
end
