class PrisonerCell < BaseCell
  property :escort
  property :family_name
  property :forenames
  property :prison_number
  property :nationality
  property :formatted_date_of_birth
  property :capitalized_sex
  property :age
  property :pnc_number
  property :cro_number

  def translation_path
    'escorts.summary.prisoner'
  end

  def edit_section_path
    identification_path(escort)
  end
end
