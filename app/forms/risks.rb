class Risks < Form
  include Form::TextToggleAttribute

  GENERAL = %i[ to_self violence from_others escape intolerant_behaviour
                prohibited_items non_association ].freeze

  GENERAL.each(&method(:text_toggle_attribute))

  def target
    super.risk_information || super.build_risk_information
  end
end
