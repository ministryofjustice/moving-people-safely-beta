class Identification < Form
  attribute :family_name,   String
  attribute :forenames,     String
  attribute :prison_number, String
  attribute :date_of_birth, Date
  attribute :sex,           String
  attribute :nationality,   String

  validates :prison_number, presence: true
  validates :sex, inclusion: %w[ male female ], allow_nil: true

  def date_of_birth
    super if super.is_a? Date
  end
end
