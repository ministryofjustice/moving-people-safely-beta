require 'rails_helper'

RSpec.describe RisksForm, type: :form do
  subject { described_class.new create(:escort) }

  input_attributes = {
    to_self: 'true',
    to_self_details: 'some text',
    violence: 'false',
    violence_details: 'some text',
    from_others: 'unknown',
    from_others_details: 'some text',
    escape: 'true',
    escape_details: 'some text',
    intolerant_behaviour: 'true',
    intolerant_behaviour_details: 'some text',
    prohibited_items: 'true',
    prohibited_items_details: 'some text',
    non_association: 'true',
    non_association_details: 'some text'
  }

  coercion_overrides = {
    to_self: true,
    violence: false,
    violence_details: nil,
    from_others: nil,
    from_others_details: nil,
    escape: true,
    intolerant_behaviour: true,
    prohibited_items: true,
    non_association: true
  }

  it_behaves_like 'a form that coerces attributes',
    input_attributes, coercion_overrides
  it_behaves_like 'a form that loads model attributes on initialize'
  it_behaves_like 'a form that syncs to a model'
  it_behaves_like 'a form that retrives or builds its target', :risks
  it_behaves_like 'a form that knows what template to render', 'risks'
  it_behaves_like 'a form that belongs to an endpoint', 'risks'
  it_behaves_like 'a form with a text toggle attribute',
    %i[ to_self
        violence
        from_others
        escape
        intolerant_behaviour
        prohibited_items
        non_association ]

  describe '#open_acct' do
    context 'when the risks to self marker has been set to yes' do
      before(:each) do
        subject.to_self = true
      end

      it_behaves_like 'a form with maybe boolean attributes', %i[ open_acct ]
    end

    { 'no' => false,
      'empty' => nil }.each do |risk_radio_name, radio_value|
      context "when the risks to self is set to #{risk_radio_name}" do
        before { subject.to_self = radio_value }

        { 'yes' => true,
          'no' => false,
          'empty' => nil }.each do |acct_radio_name, acct_value|
          context "and the acct is set to #{acct_radio_name}" do
            before { subject.open_acct = acct_value }
            its(:open_acct) { is_expected.to be_nil }
          end
        end
      end
    end
  end
end
