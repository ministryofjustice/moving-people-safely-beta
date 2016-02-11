require 'rails_helper'

RSpec.describe Auditing::LastUpdated, type: :service do
  let(:escort) { create(:escort, prisoner: build(:prisoner)) }

  describe '.for' do
    context 'when a requested field has been updated' do
      let(:fields) { %w[ family_name forenames ] }
      subject { described_class.for(fields, escort.prisoner) }

      it 'returns the version containing the changes' do
        escort.prisoner.update_attributes(family_name: 'Jones')
        escort.prisoner.update_attributes(prison_number: 'A1234XY')
        expect(subject).to eq escort.prisoner.versions.second
      end
    end

    context 'when a requested field has not been updated' do
      let(:fields) { %w[ prison_number ] }
      subject { described_class.for(fields, escort.prisoner) }

      it 'returns the first version of the record' do
        escort.prisoner.
          update_attributes(forenames: 'Mark', family_name: 'Jones')
        expect(subject).to eq escort.prisoner.versions.first
      end
    end
  end
end
