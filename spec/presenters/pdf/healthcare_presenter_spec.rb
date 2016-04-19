require 'rails_helper'

RSpec.describe Pdf::HealthcarePresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.healthcare }

  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ physical_risk_details mental_risk_details social_care_and_other_details
        allergies_details mpv_required disabilities_details
        backfilled_medications medical_professional_name contact_telephone ]

  describe '#mpv_required_class' do
    context 'when mpv_required is true' do
      let(:model) { build_stubbed(:healthcare) }
      its(:mpv_required_class) { is_expected.to eq 'checked' }
    end

    context 'when mpv_required is false' do
      its(:mpv_required_class) { is_expected.to be_blank }
    end
  end

  describe '#no_medication_class' do
    context 'when medication is false' do
      let(:model) { build_stubbed(:healthcare, medication: false) }
      its(:no_medication_class) { is_expected.to eq 'checked' }
    end

    context 'when medication is true' do
      let(:model) { build_stubbed(:healthcare, medication: true) }
      its(:no_medication_class) { is_expected.to be_blank }
    end

    context 'when medication is nil' do
      let(:model) { build_stubbed(:healthcare, medication: nil) }
      its(:no_medication_class) { is_expected.to be_blank }
    end
  end

  describe '#carrier_class' do
    context 'when value and field passed are equal' do
      let(:model) { build_stubbed(:healthcare) }

      it 'returns checked css class' do
        expect(subject.carrier_class('prisoner', 'prisoner')).to eq 'checked'
      end
    end

    context 'when value and field passed are not equal' do
      it 'returns nil' do
        expect(subject.carrier_class('prisoner', 'escort')).to be_blank
      end
    end
  end
end
