module Pdf
  class EscortPresenter
    def initialize(escort)
      @escort = escort
    end

    def prisoner_information
      @prisoner_information ||=
        Pdf::PrisonerInformationPresenter.new(@escort.prisoner)
    end
  end
end
