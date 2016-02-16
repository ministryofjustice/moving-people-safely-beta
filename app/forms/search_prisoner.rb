class SearchPrisoner
  include Form::Core

  PRISON_NUMBER_REGEX = /\A[a-z]\d{4}[a-z]{2}\z/i

  attribute :prison_number, String
  validates :prison_number, format: { with: PRISON_NUMBER_REGEX }

  def results?
    valid? && escort.present?
  end

  def no_results?
    valid? && escort.blank?
  end

  def escort
    @escort ||= Escort.find_by_prison_number(prison_number)
  end
end
