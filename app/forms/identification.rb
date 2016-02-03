class Identification < Form
  attribute :family_name,   String
  attribute :forenames,     String
  attribute :prison_number, String
  attribute :sex,           String
  attribute :nationality,   String

  date :date_of_birth

  validates :date_of_birth, date: true
  validates :prison_number, presence: true
  validates :sex, inclusion: %w[ male female ], allow_nil: true
end
