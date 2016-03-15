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

    def risks
      @risks ||= Pdf::RisksPresenter.new(@escort.risk_information)
    end

    def healthcare
      @healthcare ||= Pdf::HealthcarePresenter.new(@escort.health_information)
    end
  end
end
