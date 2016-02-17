class SearchPrisoner
  include Form::Core
  include Form::PrisonNumber

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
