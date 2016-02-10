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
    @form ||= current_page.capitalize.constantize.new(escort)
  end

  def persist_form_data
    if form.save
      flash.now[:success] = t('flash.escorts.success.update')
    else
      flash.now[:error] = t('flash.escorts.error.update')
    end
  end

  def current_page
    params[:page].to_s
  end

  def form_params
    params[form.name]
  end
end
