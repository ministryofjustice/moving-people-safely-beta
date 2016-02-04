class PrisonerInformationPresenter
  include Virtus.value_object
  include PresenterAttributes

  def initialize(model)
    @model = model
    super(section_attributes)
  end

  values do
    attribute :family_name,   HandleEmpty::Text
    attribute :forenames,     HandleEmpty::Text
    attribute :prison_number, HandleEmpty::Text
    attribute :nationality,   HandleEmpty::Text
    attribute :sex,           HandleEmpty::CapitalizedFirstChar
    attribute :date_of_birth, HandleEmpty::FormattedDate
  end

  def edit_section_path
    Rails.application.routes.url_helpers.identification_path(@model)
  end

  def age
    if original_date_of_birth.present?
      AgeCalculator.age(original_date_of_birth)
    else
      HandleEmpty.empty_text
    end
  end

private

  def section_attributes
    @model.attributes.slice(*attributes.keys.map(&:to_s))
  end

  def original_date_of_birth
    @model.date_of_birth
  end
end
