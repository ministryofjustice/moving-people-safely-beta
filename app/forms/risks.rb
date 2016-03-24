class Risks < Form
  include Form::TextToggleAttribute

  text_toggle_attribute :to_self
  text_toggle_attribute :violence
  text_toggle_attribute :from_others
  text_toggle_attribute :escape
  text_toggle_attribute :intolerant_behaviour
  text_toggle_attribute :prohibited_items
  text_toggle_attribute :non_association

  attribute :open_acct, MaybeBoolean

  def target
    super.risk_information
  end
end
