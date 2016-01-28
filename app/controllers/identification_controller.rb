class IdentificationController < ApplicationController
  def create
    form.assign_attributes params[:identification]

    if form.save
      flash.now[:success] = 'Identification data updated successfully'
    else
      flash.now[:error] = 'There were problems saving the form'
    end
    render :show
  end

  helper_method :person

  def person
    @identification_form ||= Identification.new(escort)
  end

  def form
    person
  end

private

  def escort
    @escort ||= Escort.find(params[:id])
  end
end
