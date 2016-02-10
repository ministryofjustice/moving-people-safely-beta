class EscortsController < ApplicationController
  def create
    redirect_to identification_path(Escort.create)
  end

  def update
    form.assign_attributes(form_params)
    persist_form_data
    render :show
  end

  def summary
    @summary = SummaryPresenter.new(escort)
  end

  helper_method :form

private

  def form
    @form ||= Identification.new(escort)

  def persist_form_data
    if form.save
      flash.now[:success] = t('flash.escorts.success.update')
    else
      flash.now[:error] = t('flash.escorts.error.update')
    end
  end
  end

  def form_params
    params[form.template]
  end
end
