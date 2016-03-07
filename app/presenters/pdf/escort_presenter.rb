module Pdf
  class EscortPresenter
    def initialize(escort)
      @escort = escort
    end

    def prisoner
      @prisoner ||= Pdf::PrisonerPresenter.new(@escort.prisoner)
    end

    def move
      @move ||= Pdf::MovePresenter.new(@escort.move)
    end
  end
end
