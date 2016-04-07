module Pdf
  class EscortPresenter
    def initialize(escort)
      @escort = escort
    end

    def not_for_release
      @not_for_release ||=
        Pdf::NotForReleasePresenter.new(@escort.offences)
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
      @risks ||= Pdf::RisksPresenter.new(@escort.risks)
    end

    def healthcare
      @healthcare ||= Pdf::HealthcarePresenter.new(@escort.healthcare)
    end

    def offences
      @offences ||= Pdf::OffencesPresenter.new(@escort.offences)
    end
  end
end
