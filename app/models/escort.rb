class Escort < ActiveRecord::Base
  has_paper_trail
  has_one :prisoner
  has_one :risk_information
  has_one :move
  has_one :health_information
  has_one :offence_information

  def self.find_by_prison_number(prison_number)
    joins(:prisoner).
      where(prisoners: { prison_number: prison_number }).
      first
  end

  delegate :prison_number, :full_name, :formatted_date_of_birth,
    prefix: true, to: :prisoner

  def formatted_updated_at
    updated_at.to_s(:time_with_slashed_day_month_year)
  end

  def prisoner
    super || build_prisoner
  end

  def risk_information
    super || build_risk_information
  end

  def move
    super || build_move(Move.default_origin_option)
  end

  def health_information
    super || build_health_information
  end

  def offence_information
    super || build_offence_information
  end
end
