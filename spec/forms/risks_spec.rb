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

  subject { described_class.new create(:escort) }

  input_attributes = {
    to_self: 'true',
    to_self_details: 'some text',
    to_others: 'false',
    to_others_details: 'some text',
    violence: 'unknown',
    violence_details: 'some text',
    from_others: 'true',
    from_others_details: 'some text',
    escape: 'true',
    escape_details: 'some text',
    intolerant_behaviour: 'true',
    intolerant_behaviour_details: 'some text',
    prohibited_items: 'true',
    prohibited_items_details: 'some text',
    disabilities: 'true',
    disabilities_details: 'some text',
    allergies: 'true',
    allergies_details: 'some text',
    non_association: 'true',
    non_association_details: 'some text'
  }

  coercion_overrides = {
    to_self: true,
    to_others: false,
    to_others_details: nil,
    violence: nil,
    violence_details: nil,
    from_others: true,
    escape: true,
    intolerant_behaviour: true,
    prohibited_items: true,
    disabilities: true,
    allergies: true,
    non_association: true
  }

  it_behaves_like 'a form that syncs to a model',
    input_attributes, coercion_overrides
  it_behaves_like 'a form that retrives or builds its target', :risk_information
  it_behaves_like 'a form that knows what template to render', 'risks'
  it_behaves_like 'a form that belongs to an endpoint', 'risks'
  it_behaves_like 'a form with a text toggle attribute',
    general_risks, transit_risks
end
