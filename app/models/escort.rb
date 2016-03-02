class Escort < ActiveRecord::Base
  has_paper_trail
  has_one :prisoner
  has_one :risk_information

  def self.find_by_prison_number(prison_number)
    joins(:prisoner).
      where(prisoners: { prison_number: prison_number }).
      first
  end

  delegate :prison_number, :full_name, :formatted_date_of_birth,
    prefix: true, to: :prisoner

  def formatted_updated_at
    updated_at.strftime('%H:%M %d/%m/%Y')
  end

  def prisoner
    super || build_prisoner
  end

  def risk_information
    super || build_risk_information
  end
end
