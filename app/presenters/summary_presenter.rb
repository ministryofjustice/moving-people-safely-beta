class SummaryPresenter
  def initialize(escort)
    @escort = escort
  end

  def prisoner_information
    @prisoner_information ||= PrisonerInformationPresenter.new(@escort.prisoner)
  end
end
