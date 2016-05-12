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
end
