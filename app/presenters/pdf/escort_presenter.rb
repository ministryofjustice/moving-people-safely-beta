module Pdf
  class EscortPresenter
    def initialize(escort)
      @escort = escort
    end

    def not_for_release
      @not_for_release ||=
        Pdf::NotForReleasePresenter.new(@escort.offence_information)
    end

    def front_page_markers
      @front_page_markers ||= Pdf::FrontPageMarkersPresenter.new(@escort)
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

    def offences
      @offences ||= Pdf::OffencesPresenter.new(@escort.offence_information)
    end

    def handover
      @handover ||= Pdf::HandoverPresenter.new(@escort.offence_information)
    end
  end
end
