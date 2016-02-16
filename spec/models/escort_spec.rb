require 'rails_helper'

RSpec.describe Escort, type: :model do
  subject { create(:escort) }

  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'

  describe '.find_by_prison_number' do
    subject { described_class.find_by_prison_number('A1234BC') }

    context 'when there is an associated matching prisoner' do
      it 'returns the escort' do
        escort = create(:escort,
          prisoner: build(:prisoner, prison_number: 'A1234BC'))
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
end
