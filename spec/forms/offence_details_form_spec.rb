require 'rails_helper'

RSpec.describe OffenceDetailsForm, type: :form do
  describe '#persisted?' do
    context 'when id is present' do
      it 'returns true' do
        subject = described_class.new(id: '01A')

        expect(subject.persisted?).to be true
      end
    end

    context 'when id is not present' do
      it 'returns false' do
        subject = described_class.new(id: nil)

        expect(subject.persisted?).to be false
      end
    end
  end

  describe '#empty?' do
    context 'when fields are empty' do
      it 'is set to true' do
        subject =
          described_class.new(offence_type: '', offence_status: '')

        expect(subject.empty?).to be true
      end
    end

    context 'when fields are not empty' do
      it 'is set to true' do
        subject = described_class.new(offence_type: 'value')

        expect(subject.empty?).to be false
      end
    end
  end
end
