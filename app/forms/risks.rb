class Risks < Form
  include Form::TextToggleAttribute

  text_toggle_attribute :to_self
  text_toggle_attribute :to_others
  text_toggle_attribute :violence
  text_toggle_attribute :from_others
  text_toggle_attribute :escape
  text_toggle_attribute :intolerant_behaviour
  text_toggle_attribute :prohibited_items
  text_toggle_attribute :disabilities
  text_toggle_attribute :allergies
  text_toggle_attribute :non_association

  def target
    model.risk_information || model.build_risk_information
  end
end
