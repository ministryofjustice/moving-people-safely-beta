module Pdf
  class PrisonerCell < BaseCell
    property :family_name
    property :forenames
    property :prison_number
    property :nationality
    property :date_of_birth
    property :capitalized_sex
    property :age
    property :pnc_number
    property :cro_number

    delegate :day, :month, :year,
      to: :date_of_birth, prefix: true, allow_nil: true

    def translation_path
      'pdfs.prisoner'
    end
  end
end
