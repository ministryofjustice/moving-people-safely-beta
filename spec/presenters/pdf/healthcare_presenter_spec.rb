require 'rails_helper'

RSpec.describe Pdf::HealthcarePresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.health_information }

  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ physical_risk_details mental_risk_details social_care_and_other_details
        allergies_details mpv_required disabilities_details medication_details
        medical_professional_name contact_telephone ]

  describe '#mpv_required_class' do
    context 'when mpv_required is true' do
      let(:model) { build_stubbed(:health_information) }
      its(:mpv_required_class) { is_expected.to eq 'checked' }
    end

    context 'when mpv_required is false' do
      its(:mpv_required_class) { is_expected.to be_nil }
    end
  end
end
