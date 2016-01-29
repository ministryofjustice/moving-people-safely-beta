require 'rails_helper'

RSpec.describe PrisonerInformationPresenter, type: :presenter do
  describe '#edit_section_link' do
    let(:escort) { Escort.create }
    subject { described_class.new(escort) }

    it 'returns a path to the identification form page' do
      expected_link_path = "/escort/#{escort.id}/identification"
      expect(subject.edit_section_path).to eq expected_link_path
    end
  end

  context 'attribute does not exist' do
    let(:empty_text) { I18n.t('escorts.summary.empty_text') }
    let(:escort_without_prisoner_info) { Escort.create }
    subject { described_class.new(escort_without_prisoner_info) }

    %i[
      family_name
      forenames
      date_of_birth
      sex
      prison_number
      nationality
    ].each do |attribute|
      its(attribute) do is_expected.to eq empty_text end
    end
  end

  context 'attribute does exist' do
    let(:escort_with_prisoner_info) do
      Escort.create(
        family_name: 'Bigglesworth',
        forenames: 'Tarquin',
        date_of_birth: Date.new(1972, 2, 13),
        sex: 'male',
        prison_number: 'A1234BC',
        nationality: 'British'
      )
    end
    subject { described_class.new(escort_with_prisoner_info) }

    its(:family_name)   do is_expected.to eq 'Bigglesworth' end
    its(:forenames)     do is_expected.to eq 'Tarquin' end
    its(:date_of_birth) do is_expected.to eq '13/02/1972' end
    its(:sex)           do is_expected.to eq 'M' end
    its(:prison_number) do is_expected.to eq 'A1234BC' end
    its(:nationality)   do is_expected.to eq 'British' end
  end
end