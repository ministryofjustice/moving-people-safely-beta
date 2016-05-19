class CreateEscortForm < Form
  include Form::PrisonNumber

  validate :prison_number_uniqueness

  def initialize(params)
    assign_attributes(params)
  end

  attr_reader :escort

private

  def persist
    nomis_data = CreatePrisonerFromNomis.new(prison_number).call
    prisoner_params = {prison_number: prison_number}.merge(nomis_data)
    @escort = Escort.create(prisoner: Prisoner.new(prisoner_params))
  end

  def prison_number_uniqueness
    if Escort.find_by_prison_number(prison_number)
      errors.add(:prison_number, :taken)
    end
  end
end
