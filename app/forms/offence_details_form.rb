class OffenceDetailsForm
  include Form::Core

  STATUS_TYPES = %w[ outstanding_charge
                     serving_sentence
                     on_remand
                     licence_recall ]

  attribute :id, String
  attribute :offence_type, String
  attribute :offence_status, String
  attribute :not_for_release, Boolean
  attribute :current_offence, Boolean
  attribute :_destroy, Boolean

  validates :offence_type, presence: true, unless: :_destroy
  validates :offence_status, inclusion: { in: STATUS_TYPES }, allow_blank: true

  def empty?
    [offence_type, offence_status].all?(&:blank?)
  end

  def persisted?
    id.present?
  end
end
