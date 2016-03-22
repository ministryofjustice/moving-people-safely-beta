require 'rails_helper'

RSpec.describe Pdf::NotForReleasePresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.offence_information }

  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ not_for_release_details ]

  describe '#not_for_release_class' do
    context 'when not_for_release is true' do
      let(:model) { build_stubbed(:offence_information) }
      its(:not_for_release_class) { is_expected.to eq 'checked' }
    end

    context 'when not_for_release is false' do
      its(:not_for_release_class) { is_expected.to be_blank }
    end
  end
end
