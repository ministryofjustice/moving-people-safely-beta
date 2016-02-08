require 'rails_helper'

RSpec.describe DateHashParser, type: :service do
  subject { described_class.new(date_hash) }

  describe '.initialize' do
    let(:date_hash) { { day: '12', month: '', year: '1981' } }

    it 'sets data_hash' do
      expect(subject.date_hash).to eq date_hash
    end
  end

  describe '#perform' do
    context 'with an empty date hash' do
      let(:date_hash) { { day: '', month: '', year: '' } }

      it 'returns an EmptyDate' do
        expect(subject.perform).to eq DateHashParser::EmptyDate.new(date_hash)
      end
    end

    context 'with a non numeric hash' do
      let(:date_hash) { { day: 'abc', month: 'de', year: 'fg' } }

      it 'returns an InvalidDate' do
        expect(subject.perform).to eq DateHashParser::InvalidDate.new(date_hash)
      end
    end

    context 'with a partially filled hash' do
      let(:date_hash) { { day: '12', month: '', year: '1981' } }

      it 'returns an InvalidDate' do
        expect(subject.perform).to eq DateHashParser::InvalidDate.new(date_hash)
      end
    end

    context 'with a year with less than 4 digits hash' do
      let(:date_hash) { { day: '12', month: '5', year: '81' } }

      it 'returns an InvalidDate' do
        expect(subject.perform).to eq DateHashParser::InvalidDate.new(date_hash)
      end
    end

    context 'with out of segment date hash' do
      let(:date_hash) { { day: '45', month: '5', year: '1981' } }

      it 'return an InvalidDate' do
        expect(subject.perform).to eq DateHashParser::InvalidDate.new(date_hash)
      end
    end

    context 'with a valid date hash' do
      let(:date_hash) { { day: '25', month: '5', year: '1981' } }

      it 'return a ValidDate' do
        expect(subject.perform).to be_a DateHashParser::ValidDate
      end
    end
  end
end
