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

  describe '#risks' do
    context 'when risks exists' do
      subject { create(:escort, :with_risks) }
      its(:risks) { is_expected.to be_persisted }
      its(:risks) { is_expected.to be_kind_of(Risks) }
    end

    context 'when risks does not exist' do
      subject { create(:escort) }
      its(:risks) { is_expected.to_not be_persisted }
      its(:risks) { is_expected.to be_kind_of(Risks) }
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

  describe '#healthcare' do
    context 'when healthcare exists' do
      subject { create(:escort, :with_healthcare) }
      its(:healthcare) { is_expected.to be_persisted }
      its(:healthcare) { is_expected.to be_kind_of(Healthcare) }
    end

    context 'when healthcare does not exist' do
      subject { create(:escort) }
      its(:healthcare) { is_expected.to_not be_persisted }
      its(:healthcare) { is_expected.to be_kind_of(Healthcare) }
    end
  end

  describe '#offences' do
    context 'when offences exists' do
      subject { create(:escort, :with_offences) }
      its(:offences) { is_expected.to be_persisted }
      its(:offences) do
        is_expected.to be_kind_of(Offences)
      end
    end

    context 'when offences does not exist' do
      subject { create(:escort) }
      its(:offences) { is_expected.to_not be_persisted }
      its(:offences) do
        is_expected.to be_kind_of(Offences)
      end
    end
  end
end
