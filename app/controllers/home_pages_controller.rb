class HomePagesController < ApplicationController
  def search
    form.validate
    render :show
  end

  helper_method :form

  def form
    @form ||= SearchPrisoner.new(params[:search_prisoner])
  end
end
