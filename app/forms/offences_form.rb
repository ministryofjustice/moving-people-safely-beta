class OffencesForm < Form
  include Form::TextToggleAttribute

  text_toggle_attribute :not_for_release
  text_toggle_attribute :must_return
  text_toggle_attribute :must_not_return
  text_toggle_attribute :other_offences

  def target
    super.offence_information
  end
end
