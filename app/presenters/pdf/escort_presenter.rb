module Pdf
  class EscortPresenter
    def initialize(escort)
      @escort = escort
    end

    def prisoner
      @prisoner ||= Pdf::PrisonerPresenter.new(@escort.prisoner)
    end
  end
end
