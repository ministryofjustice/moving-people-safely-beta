class PrisonerInformationPresenter
  def initialize(model)
    @model = model
  end

  delegate :family_name, :forenames, :prison_number, :nationality,
    to: :prisoner

  delegate :sex, :date_of_birth, to: :prisoner, prefix: true

  def edit_section_path
    Rails.application.routes.url_helpers.identification_path(@model)
  end

  def sex
    if prisoner_sex.present?
      prisoner_sex.chr.capitalize
    end
  end

  def date_of_birth
    if prisoner_date_of_birth.present?
      prisoner_date_of_birth.strftime('%d/%m/%Y')
    end
  end

  def age
    if prisoner_date_of_birth.present?
      AgeCalculator.age(prisoner_date_of_birth)
    end
  end

private

  def prisoner
    @model.prisoner || @model.build_prisoner
  end
end
