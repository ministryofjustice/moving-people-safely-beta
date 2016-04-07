require 'rails_helper'

RSpec.describe PrisonerInformationForm, type: :form do
  let(:escort) { create(:escort) }

  subject { described_class.new(escort) }

  input_attributes = {
    family_name: 'Patti',
    forenames: 'Smith',
    sex: 'female',
    nationality: 'American',
    date_of_birth: { day: '10', month: '2', year: '1977' },
    cro_number: 'SOMECRO',
    pnc_number: 'SOMEPNC'
  }

  coercion_overrides = { date_of_birth: Date.civil(1977, 2, 10) }

  it_behaves_like 'a form that syncs to a model',
    input_attributes, coercion_overrides
  it_behaves_like 'a form that retrives or builds its target', :prisoner
  it_behaves_like 'a form that knows what template to render',
    'prisoner_information'
  it_behaves_like 'a form that belongs to an endpoint', 'prisoner-information'
  it_behaves_like 'a form with dates', %i[ date_of_birth ]

  it { is_expected.to validate_inclusion_of(:sex).in_array(%w[ male female ]) }

  describe '#prison_number' do
    it 'delegates prison number to the model' do
      expect(subject.prison_number).to eq escort.prisoner.prison_number
    end
  end

  describe 'age validation' do
    it 'does not allow ages less than 16' do
      subject.date_of_birth = 15.years.ago.to_date
      subject.validate

      is_expected.to have_error_for(:date_of_birth).
        with_message(/out of range/)
    end

    it 'does not allow ages greater than 100' do
      subject.date_of_birth = 101.years.ago.to_date
      subject.validate

      is_expected.to have_error_for(:date_of_birth).
        with_message(/out of range/)
    end

    it 'allows ages between 16 & 100' do
      years = (16..100).map { |y| y.years.ago.to_date }
      years.each do |year|
        subject.date_of_birth = year
        subject.validate

        is_expected.not_to have_error_for(:date_of_birth)
      end
    end
  end
end
