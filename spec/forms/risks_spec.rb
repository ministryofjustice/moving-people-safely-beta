require 'rails_helper'

RSpec.describe Risks, type: :form do
  general_risks = %i[ to_self to_others violence from_others
                      escape intolerant_behaviour prohibited_items ]
  transit_risks = %i[ disabilities allergies non_association ]

  describe '::GENERAL' do
    specify do
      expect(described_class::GENERAL).to match_array general_risks
    end
  end

  describe '::TRANSIT' do
    specify do
      expect(described_class::TRANSIT).to match_array transit_risks
    end
  end

  it_behaves_like 'a form with a text toggle attribute',
    general_risks, transit_risks
end
