require 'rails_helper'

RSpec.describe Pdf::PrisonerPresenter, type: :presenter do
  let(:model) { build_stubbed(:prisoner) }
  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ prison_number
        nationality
        capitalized_sex
        date_of_birth
        age
        cro_number
        pnc_number ]

  %i[ day month year ].each do |method|
    it { is_expected.to delegate_method(method).to(:date_of_birth).with_prefix }
  end

  describe '#names' do
    context 'when no names are present' do
      it 'returns an empty string' do
        model.assign_attributes(family_name: nil, forenames: nil)
        expect(subject.names).to be_empty
      end
    end
    context 'when only the forename is present' do
      it 'returns only the forename' do
        model.assign_attributes(family_name: nil, forenames: 'Charlie')
        expect(subject.names).to eq 'Charlie'
      end
    end
    context 'when only the family name is present' do
      it 'returns only the forename' do
        model.assign_attributes(family_name: 'Babbage', forenames: nil)
        expect(subject.names).to eq 'Babbage'
      end
    end
    context 'when both names are present' do
      it 'returns both in the order family name, forenames seperated by a /' do
        model.assign_attributes(family_name: 'Babbage', forenames: 'Charlie')
        expect(subject.names).to eq 'Babbage \ Charlie'
      end
    end
  end
end
