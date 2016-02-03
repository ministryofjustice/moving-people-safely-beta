require 'rails_helper'

RSpec.describe CompatibleDate, type: :service do
  describe '.for' do
    subject { described_class.for(value) }

    context 'with a date' do
      let(:value) { Date.civil(1981, 5, 25) }

      it 'returns the date' do
        expect(subject).to eq value
      end
    end

    context 'with valid date hash' do
      let(:value) { { day: '25', month: '5', year: '1981' } }

      it 'coerces it to a date' do
        expect(subject).to eq Date.civil(1981, 5, 25)
      end

      context 'when invoking invalid?' do
        it 'responds false' do
          expect(subject.invalid?).to be false
        end
      end
    end

    context 'with out of segment date hash' do
      let(:value) { { day: '45', month: '5', year: '1981' } }

      it 'return an InvalidDate' do
        expect(subject).to eq CompatibleDate::InvalidDate.new(value)
      end

      context 'when invoking invalid?' do
        it 'responds true' do
          expect(subject.invalid?).to be true
        end
      end
    end

    context 'with a non acceptable hash with 2 digit year' do
      let(:value) { { day: '1', month: '5', year: '81' } }

      it 'coerces it to a date' do
        expect(subject).to eq Date.civil(81, 5, 1)
      end

      context 'when invoking invalid?' do
        it 'responds true' do
          expect(subject.invalid?).to be true
        end
      end
    end

    context 'with a text filled hash' do
      let(:value) { { day: 'abc', month: 'de', year: 'fg' } }

      it 'returns an InvalidDate' do
        expect(subject).to eq CompatibleDate::InvalidDate.new(value)
      end

      context 'when invoking invalid?' do
        it 'responds true' do
          expect(subject.invalid?).to be true
        end
      end
    end

    context 'with an empty hash' do
      let(:value) { { day: '', month: '', year: '' } }

      it 'sets attribute value to that text filled hash' do
        expect(subject).to eq CompatibleDate::EmptyDate.new(value)
      end

      context 'when invoking invalid?' do
        it 'responds false' do
          expect(subject.invalid?).to be false
        end
      end
    end
  end
end
