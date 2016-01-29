require 'rails_helper'

RSpec.describe Identification, type: :form do
  let(:escort) { Escort.new }

  subject { described_class.new(escort) }

  it { is_expected.to validate_presence_of(:prison_number) }

  describe 'validating' do
    describe 'sex' do
      context 'when present' do
        context 'and included in the list' do
          it 'is valid' do
            subject.sex = 'male'
            subject.valid?
            expect(subject.errors[:sex]).to be_empty
          end
        end

        context 'and not included in the list' do
          it 'is not valid' do
            subject.sex = 'camel'
            subject.valid?
            expect(subject.errors[:sex]).to_not be_empty
          end
        end
      end

      context 'when not present' do
        it 'is valid' do
          subject.sex = nil
          subject.valid?
          expect(subject.errors[:sex]).to be_empty
        end
      end
    end
  end

  describe '#date_of_birth' do
    context 'with a valid date' do
      it 'returns a date' do
        subject.date_of_birth = { day: '1', month: '2', year: '2016' }
        expect(subject.date_of_birth).to eq Date.parse('1/2/2016')
      end
    end

    context 'with an empty date' do
      it 'returns nil' do
        subject.date_of_birth = { day: '', month: '', year: '' }
        expect(subject.date_of_birth).to eq nil
      end
    end
  end
end
