require 'rails_helper'

RSpec.describe Escort, type: :model do
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
end
