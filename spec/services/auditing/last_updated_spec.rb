require 'rails_helper'

RSpec.describe Auditing::LastUpdated, type: :service do
  let(:escort) { create(:escort) }

  describe '.for' do
    context 'when a requested field has been updated' do
      subject { described_class.for(%w[ family_name forenames ], escort) }

      it 'returns the version containing the changes' do
        escort.update_attributes(family_name: 'Jones')
        escort.update_attributes(prison_number: 'A1234XY')
        expect(subject).to eq escort.versions[1]
      end
    end

    context 'when a requested field has not been updated' do
      subject { described_class.for(%w[ prison_number ], escort) }

      it 'returns the first version of the record' do
        escort.update_attributes(forenames: 'Mark', family_name: 'Jones')
        expect(subject).to eq escort.versions[0]
      end
    end
  end
end
