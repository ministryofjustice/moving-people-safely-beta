class SummaryCell < BaseCell
  property :prisoner
  property :move

  delegate :family_name, :forenames, :prison_number, :nationality,
    :capitalized_sex, :formatted_date_of_birth, :age, :cro_number,
    :pnc_number, to: :prisoner

  delegate :origin, :destination, :date_of_travel, :reason, to: :move
  private :date_of_travel

  delegate :day, :month, :year,
    to: :date_of_travel, prefix: true, allow_nil: true

  def edit_prisoner_section_path
    prisoner_path(model)
  end

  def edit_move_section_path
    move_path(model)
  end

  def formatted_date_of_travel
    if date_of_travel.present?
      date_of_travel.to_s(:slashed_day_month_year)
    end
  end
end
