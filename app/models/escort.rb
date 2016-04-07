class Escort < ActiveRecord::Base
  has_paper_trail
  has_one :prisoner
  has_one :risks
  has_one :move
  has_one :healthcare
  has_one :offences

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

  def risks
    super || build_risks
  end

  def move
    super || build_move(Move.default_origin_option)
  end

  def healthcare
    super || build_healthcare
  end

  def offences
    super || build_offences
  end
end
