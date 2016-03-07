class EscortsController < ApplicationController
  def create
    create_escort_form = CreateEscort.new(prison_number_params)
    if create_escort_form.save
      redirect_to identification_path(create_escort_form.escort)
    else
      redirect_to root_path
    end
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
    @form ||= current_page.camelcase.constantize.new(escort)
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

  def prison_number_params
    params.slice(:prison_number)
  end
end
