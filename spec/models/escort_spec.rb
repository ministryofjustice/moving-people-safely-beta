require 'rails_helper'

RSpec.describe Escort, type: :model do
  subject { create(:escort) }

  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'

  describe '.find_by_prison_number' do
    subject { described_class.find_by_prison_number('A1234BC') }

    context 'when there is an associated matching prisoner' do
      it 'returns the escort' do
        escort = create(:escort, :with_prisoner, prison_number: 'A1234BC')
        expect(subject).to eq escort
      end
    end

    context 'when there is no associated matching prisoner' do
      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#formatted_updated_at' do
    it 'returns a time in the format `HH:MM DD/MM/YYYY`' do
      travel_to(DateTime.new(2016, 2, 3, 12, 45)) do
        subject.touch
        expect(subject.formatted_updated_at).to eq '12:45 03/02/2016'
      end
    end
  end

  context 'delegation' do
    subject { create(:escort, :with_prisoner) }

    it do
      is_expected.to delegate_method(:prison_number).to(:prisoner).with_prefix
    end

    it do
      is_expected.to delegate_method(:full_name).to(:prisoner).with_prefix
    end

    it do
      is_expected.to delegate_method(:formatted_date_of_birth).
        to(:prisoner).with_prefix
    end
  end

  describe '#prisoner' do
    context 'when a prisoner exists' do
      subject { create(:escort, :with_prisoner) }
      its(:prisoner) { is_expected.to be_persisted }
      its(:prisoner) { is_expected.to be_kind_of(Prisoner) }
    end

    context 'when a prisoner does not exist' do
      subject { create(:escort) }
      its(:prisoner) { is_expected.to_not be_persisted }
      its(:prisoner) { is_expected.to be_kind_of(Prisoner) }
    end
  end

  describe '#risk_information' do
    context 'when risk_information exists' do
      subject { create(:escort, :with_risk_information) }
      its(:risk_information) { is_expected.to be_persisted }
      its(:risk_information) { is_expected.to be_kind_of(RiskInformation) }
    end

    context 'when risk_information does not exist' do
      subject { create(:escort) }
      its(:risk_information) { is_expected.to_not be_persisted }
      its(:risk_information) { is_expected.to be_kind_of(RiskInformation) }
    end
  end

  describe '#move' do
    context 'when a move exists' do
      subject { create(:escort, :with_move) }
      its(:move) { is_expected.to be_persisted }
      its(:move) { is_expected.to be_kind_of(Move) }
    end

    context 'when a move does not exist' do
      subject { create(:escort) }
      its(:move) { is_expected.not_to be_persisted }
      its(:move) { is_expected.to be_kind_of(Move) }

      it 'has a default origin set' do
        expect(subject.move.origin).to eq 'HMP Bedford'
      end
    end
  end
end
