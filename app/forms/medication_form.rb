class MedicationForm
  include Form::Core

  CARRIER_TYPES = %w[ escort prisoner ]

  attribute :id, String
  attribute :description, String
  attribute :administration, String
  attribute :carrier, String
  attribute :_destroy, Boolean

  validates :description, presence: true, unless: :_destroy
  validates :carrier, inclusion: { in: CARRIER_TYPES }, allow_blank: true

  def empty?
    [description, administration, carrier].all?(&:blank?)
  end

  def persisted?
    id.present?
  end
end
