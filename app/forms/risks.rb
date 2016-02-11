class Risks < Form
  include Form::TextToggleAttribute

  GENERAL = %i[ to_self to_others violence from_others escape
                intolerant_behaviour prohibited_items ].freeze
  TRANSIT = %i[ disabilities allergies non_association ].freeze

  [GENERAL, TRANSIT].flatten.each(&method(:text_toggle_attribute))

  def target
    model.risk_information || model.build_risk_information
  end
end
