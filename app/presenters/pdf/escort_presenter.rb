module Pdf
  class EscortPresenter
    def initialize(escort_model)
      @escort_model = escort_model
    end

    def prisoner_information
      @prisoner_information ||=
        Pdf::PrisonerInformationPresenter.new(@escort_model)
    end
  end
end
