class HomePagesController < ApplicationController
  def search
    form.validate
    render :show
  end

  helper_method :form

  def form
    @form ||= SearchPrisonerForm.new(params[:search_prisoner])
  end
end
