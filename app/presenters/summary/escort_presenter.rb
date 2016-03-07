module Summary
  class EscortPresenter
    def initialize(escort)
      @escort = escort
    end

    def prisoner
      @prisoner ||= Summary::PrisonerPresenter.new(@escort.prisoner)
    end

    def move
      @move ||= Summary::MovePresenter.new(@escort.move)
    end
  end
end
