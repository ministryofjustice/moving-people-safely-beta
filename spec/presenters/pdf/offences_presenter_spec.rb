require 'rails_helper'

RSpec.describe Pdf::OffencesPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.offences }

  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ must_return_details must_not_return_details offence_details ]

  describe '#must_return_class' do
    context 'when must_return is true' do
      let(:model) { build_stubbed(:offences) }
      its(:must_return_class) { is_expected.to eq 'checked' }
    end

    context 'when must_return is false' do
      its(:must_return_class) { is_expected.to be_blank }
    end
  end

  describe '#must_not_return_class' do
    context 'when must_not_return is true' do
      let(:model) { build_stubbed(:offences) }
      its(:must_not_return_class) { is_expected.to eq 'checked' }
    end

    context 'when must_not_return is false' do
      its(:must_not_return_class) { is_expected.to be_blank }
    end
  end

  describe '#not_for_release_class' do
    context 'when not_for_release is true on offence_details' do
      it 'returns checked class' do
        offence_details =
          build_stubbed(:offence_details, not_for_release: true)

        expect(subject.not_for_release_class(offence_details)).to eq 'checked'
      end
    end

    context 'when not_for_release is false on offence_details' do
      it 'returns nil' do
        offence_details =
          build_stubbed(:offence_details, not_for_release: false)

        expect(subject.not_for_release_class(offence_details)).to be_nil
      end
    end
  end

  describe '#current_offence_class' do
    context 'when current_offence is true on offence_details' do
      it 'returns checked class' do
        offence_details =
          build_stubbed(:offence_details, current_offence: true)

        expect(subject.current_offence_class(offence_details)).to eq 'checked'
      end
    end

    context 'when current_offence is false on offence_details' do
      it 'returns nil' do
        offence_details =
          build_stubbed(:offence_details, current_offence: false)

        expect(subject.current_offence_class(offence_details)).to be_nil
      end
    end
  end

  describe '#offence_status' do
    context 'when offence_status is set on offence_details' do
      it 'returns the offence_status from translations' do
        offence_details =
          build_stubbed(:offence_details)

        expect(subject.offence_status(offence_details)).
          to eq 'Outstanding charge'
      end
    end

    context 'when offence_status is blank on offence_details' do
      it 'returns nil' do
        offence_details =
          build_stubbed(:offence_details, offence_status: '')

        expect(subject.offence_status(offence_details)).to be_nil
      end
    end
  end
end
