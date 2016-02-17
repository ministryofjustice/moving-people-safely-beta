require 'rails_helper'

RSpec.describe PrisonerInformationPresenter, type: :presenter do
  describe '#edit_section_link' do
    let(:escort) { create(:escort) }
    subject { described_class.new(escort) }

    it 'returns a path to the identification form page' do
      expected_link_path = "/escort/#{escort.id}/identification"
      expect(subject.edit_section_path).to eq expected_link_path
    end
  end

  context 'attribute does not exist' do
    let(:escort) { create(:escort, prisoner: build(:prisoner, :empty)) }
    subject { described_class.new(escort) }

    %i[
      family_name
      forenames
      date_of_birth
      sex
      prison_number
      nationality
    ].each do |attribute|
      its(attribute) do is_expected.to be_nil end
    end
  end

  context 'attribute does exist' do
    let(:escort) { create(:escort, :with_prisoner) }
    subject { described_class.new(escort) }

    its(:family_name)   { is_expected.to eq 'Bigglesworth' }
    its(:forenames)     { is_expected.to eq 'Tarquin' }
    its(:date_of_birth) { is_expected.to eq '13/02/1972' }
    its(:sex)           { is_expected.to eq 'M' }
    its(:prison_number) { is_expected.to eq 'A1234BC' }
    its(:nationality)   { is_expected.to eq 'British' }

    it 'shows the correct age' do
      travel_to(Date.new(2015, 2, 15)) { expect(subject.age).to eq 43 }
    end
  end
end
