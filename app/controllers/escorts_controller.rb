class EscortsController < ApplicationController
  def create
    redirect_to identification_path(Escort.create)
  end

  def summary
    @summary = SummaryPresenter.new(escort)
  end

private

  def escort
    @escort ||= Escort.find(params[:id])
  end
end
