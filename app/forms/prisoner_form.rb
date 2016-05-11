class PrisonerForm < Form
  include Form::DateHandling

  attribute :family_name,   String
  attribute :forenames,     String
  attribute :sex,           String
  attribute :nationality,   String
  attribute :cro_number,    String
  attribute :pnc_number,    String
  attribute :has_aliases,   Form::MaybeBoolean
  attribute :aliases,       Array[String], coercer: MultipleStringsCoercer

  date :date_of_birth

  validates :date_of_birth, prisoner_age: true
  validates :sex, inclusion: %w[ male female ], allow_nil: true

  delegate :prison_number, to: :target

private

  def load_model_data
    super
    self.aliases = target.backfilled_aliases
  end

  def persist
    transformed_attributes = TransformAttributes.new(attributes).call
    target.update_attributes(transformed_attributes)
    reload
  end
end
