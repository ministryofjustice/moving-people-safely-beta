class SummaryPresenter
  def initialize(escort)
    @escort = escort
  end

  def prisoner
    @prisoner ||= PrisonerPresenter.new(@escort.prisoner)
  end

  def move
    @move ||= MovePresenter.new(@escort.move)
  end
end
