class EscortsController < ApplicationController
  def create
    redirect_to identification_path(Escort.create)
  end

  def update
    form.assign_attributes(form_params)

    if form.save
      flash.now[:success] = t('flash.escorts.success.update')
    else
      flash.now[:error] = t('flash.escorts.error.update')
    end
    render :show
  end

  def summary
    @summary = SummaryPresenter.new(escort)
  end

  helper_method :form

private

  def form
    @form ||= Identification.new(escort)
  end

  def form_params
    params[form.template]
  end
end
