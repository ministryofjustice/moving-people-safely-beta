require 'rails_helper'

RSpec.describe Pdf::HandoverPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  let(:model) { escort.offence_information }

  subject { described_class.new(model) }

  it_behaves_like 'a presenter that delegates methods to the model',
    %i[ must_return_details must_not_return_details ]

  describe '#must_return_class' do
    context 'when must_return is true' do
      let(:model) { build_stubbed(:offence_information) }
      its(:must_return_class) { is_expected.to eq 'checked' }
    end

    context 'when must_return is false' do
      its(:must_return_class) { is_expected.to be_blank }
    end
  end

  describe '#must_not_return_class' do
    context 'when must_not_return is true' do
      let(:model) { build_stubbed(:offence_information) }
      its(:must_not_return_class) { is_expected.to eq 'checked' }
    end

    context 'when must_not_return is false' do
      its(:must_not_return_class) { is_expected.to be_blank }
    end
  end
end
