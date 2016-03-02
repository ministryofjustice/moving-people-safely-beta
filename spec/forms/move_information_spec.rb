require 'rails_helper'

RSpec.describe MoveInformation, type: :form do
  let(:escort) { create(:escort) }

  subject { described_class.new(escort) }

  input_attributes = {
    origin: 'HMP Clive House',
    destination: 'Petty France',
    date_of_travel: { day: '23', month: '2', year: '2016' },
    reason: 'Expected to attend show the thing'
  }
  coercion_overrides = { date_of_travel: Date.civil(2016, 2, 23) }
  it_behaves_like 'a form that syncs to a model',
    input_attributes, coercion_overrides

  it_behaves_like 'a form that retrives or builds its target', :move

  it_behaves_like 'a form that knows what template to render',
    'move_information'

  it_behaves_like 'a form that belongs to an endpoint',
    'move-information'

  it_behaves_like 'a form with dates', %i[ date_of_travel ]

  describe '#formatted_date_today' do
    it 'returns the current date in the format "DD MM YYYY"' do
      travel_to(Date.civil(2016, 2, 23)) do
        expect(subject.formatted_date_today).to eq '23 02 2016'
      end
    end
  end
end
