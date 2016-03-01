class PrisonerInformationPresenter
  def initialize(model)
    @model = model
  end

  delegate :family_name, :forenames, :prison_number, :nationality,
    :capitalized_sex, :formatted_date_of_birth, :age, :cro_number, :pnc_number,
    to: :prisoner

  def edit_section_path
    Rails.application.routes.url_helpers.identification_path(@model)
  end

private

  def prisoner
    @model.prisoner || @model.build_prisoner
  end
end
