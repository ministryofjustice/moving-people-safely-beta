require 'rails_helper'

RSpec.describe Pdf::PrisonerInformationPresenter, type: :presenter do
  let(:escort) { create(:escort) }
  subject { described_class.new(escort) }

  context 'attribute does not exist' do
    let(:escort) { create(:escort, prisoner: build(:prisoner, :empty)) }
    subject { described_class.new(escort) }

    %i[
      family_name
      forenames
      date_of_birth_day
      date_of_birth_month
      date_of_birth_year
      sex
      age
      prison_number
      nationality
      cro_number
      pnc_number
    ].each do |attribute|
      its(attribute) { is_expected.to be_nil }
    end
  end

  context 'attribute does exist' do
    let(:escort) { create(:escort, :with_prisoner) }
    subject { described_class.new(escort) }

    its(:family_name)         { is_expected.to eq 'Bigglesworth' }
    its(:forenames)           { is_expected.to eq 'Tarquin' }
    its(:date_of_birth_day)   { is_expected.to eq 13 }
    its(:date_of_birth_month) { is_expected.to eq 2 }
    its(:date_of_birth_year)  { is_expected.to eq 1972 }
    its(:sex)                 { is_expected.to eq 'M' }
    its(:prison_number)       { is_expected.to eq 'A1234BC' }
    its(:nationality)         { is_expected.to eq 'British' }
    its(:cro_number)          { is_expected.to eq 'SOMECRO' }
    its(:pnc_number)          { is_expected.to eq 'SOMEPNC' }

    it 'shows the correct age' do
      travel_to(Date.new(2015, 2, 15)) { expect(subject.age).to eq 43 }
    end
  end
end
