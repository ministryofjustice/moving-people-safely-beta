require 'rails_helper'

RSpec.describe MoveForm, type: :form do
  subject { described_class.new(create :escort) }

  input_attributes = {
    origin: 'HMP Clive House',
    destination: 'Petty France',
    date_of_travel: { day: '23', month: '2', year: '2016' },
    reason: 'Expected to attend show the thing'
  }

  coercion_overrides = { date_of_travel: Date.civil(2016, 2, 23) }

  it_behaves_like 'a form that coerces attributes',
    input_attributes, coercion_overrides
  it_behaves_like 'a form that loads model attributes on initialize'
  it_behaves_like 'a form that syncs to a model'
  it_behaves_like 'a form that retrives or builds its target', :move
  it_behaves_like 'a form that knows what template to render', 'move'
  it_behaves_like 'a form that belongs to an endpoint', 'move'
  it_behaves_like 'a form with dates', %i[ date_of_travel ]

  describe '#formatted_date_today' do
    it 'returns the current date in the format "DD MM YYYY"' do
      travel_to(Date.civil(2016, 2, 23)) do
        expect(subject.formatted_date_today).to eq '23 02 2016'
      end
    end
  end

  describe 'validations' do
    describe 'date_of_travel' do
      it 'allows blank dates' do
        subject.date_of_travel = nil
        subject.validate
        is_expected.not_to have_error_for(:date_of_travel)
      end

      it 'allows todays date' do
        subject.date_of_travel = Date.today
        subject.validate
        is_expected.not_to have_error_for(:date_of_travel)
      end

      it 'allows dates in the future' do
        subject.date_of_travel = Date.tomorrow
        subject.validate
        is_expected.not_to have_error_for(:date_of_travel)
      end

      it 'does not allow dates in the past' do
        subject.date_of_travel = Date.yesterday
        subject.validate
        is_expected.to have_error_for(:date_of_travel).
          with_message(/in the past/)
      end
    end
  end
end
