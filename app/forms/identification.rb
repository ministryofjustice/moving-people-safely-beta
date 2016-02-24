class Identification < Form
  include Form::DateHandling

  attribute :family_name,   String
  attribute :forenames,     String
  attribute :sex,           String
  attribute :nationality,   String
  attribute :cro_number,    String
  attribute :pnc_number,    String
  date :date_of_birth

  validates :sex, inclusion: %w[ male female ], allow_nil: true

  delegate :prison_number, to: :target

  def target
    super.prisoner || super.build_prisoner
  end
end
