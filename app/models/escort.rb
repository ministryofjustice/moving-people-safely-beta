class Escort < ActiveRecord::Base
  has_paper_trail
  has_one :prisoner
  has_one :risk_information

  def self.find_by_prison_number(prison_number)
    joins(:prisoner).
      where(prisoners: { prison_number: prison_number }).
      first
  end

  def formatted_updated_at
    updated_at.strftime('%H:%M %d/%m/%Y')
  end
end
