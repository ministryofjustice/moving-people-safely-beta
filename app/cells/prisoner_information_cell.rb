class PrisonerInformationCell < BaseCell
  property :escort
  property :family_name
  property :forenames
  property :prison_number
  property :nationality
  property :formatted_date_of_birth
  property :capitalized_sex
  property :age

  def translation_path
    'escorts.summary.prisoner_information'
  end
end
