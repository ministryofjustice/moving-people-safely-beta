require 'rails_helper'

RSpec.describe SearchPrisonerForm, type: :form do
  subject { described_class.new(prison_number: 'A1234BC') }

  it_behaves_like 'a form with prison_number'

  context 'validations' do
    context 'prison_number' do
      context 'with valid format' do
        it { is_expected.to be_valid }
      end

      context 'with invalid format' do
        subject { described_class.new(prison_number: 'invalid') }
        it { is_expected.to_not be_valid }
      end
    end
  end

  describe '#results?' do
    context 'when results exist' do
      before { create(:escort, :with_prisoner) }
      its(:results?) { is_expected.to be true }
    end

    context 'when results dont exist' do
      its(:results?) { is_expected.to be false }
    end

    context 'without prison_number' do
      subject { described_class.new }
      its(:results?) { is_expected.to be false }
    end
  end

  describe '#no_results?' do
    context 'when results exist' do
      before { create(:escort, :with_prisoner) }
      its(:no_results?) { is_expected.to be false }
    end

    context 'when results dont exist' do
      its(:no_results?) { is_expected.to be true }
    end

    context 'without prison_number' do
      subject { described_class.new }
      its(:no_results?) { is_expected.to be false }
    end
  end

  describe '#escort' do
    context 'when present' do
      it 'returns the escort' do
        escort = create(:escort, :with_prisoner, prison_number: 'A1234BC')
        expect(subject.escort).to eq escort
      end
    end

    context 'when not present' do
      its(:escort) { is_expected.to be_nil }
    end
  end
end
