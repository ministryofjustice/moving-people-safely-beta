module Pdf
  class PrisonerInformationCell < BaseCell
    property :family_name
    property :forenames
    property :prison_number
    property :nationality
    property :date_of_birth
    property :capitalized_sex
    property :age

    delegate :day, :month, :year,
      to: :date_of_birth, prefix: true, allow_nil: true

    def translation_path
      'pdfs.prisoner_information'
    end
  end
end
