class SummaryPresenter
  def initialize(escort_model)
    @escort_model = escort_model
  end

  def prisoner_information
    @prisoner_information ||= PrisonerInformationPresenter.new(@escort_model)
  end
end
