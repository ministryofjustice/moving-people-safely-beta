class IdentificationController < ApplicationController
  def create
    if person.update_attributes person_params
      flash.now[:success] = 'Identification data updated successfully'
    else
      flash.now[:error] = 'There were problems saving the form'
    end
    render :show
  end

  helper_method :person

  def person
    @person ||= escort.person || escort.build_person
  end

private

  def escort
    @escort ||= Escort.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:prison_number,
      :family_name, :forenames, :date_of_birth, :sex,
      :nationality, :pnc_number, :cro_number)
  end
end
