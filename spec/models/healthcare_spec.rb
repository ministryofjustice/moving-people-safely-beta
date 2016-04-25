require 'rails_helper'

RSpec.describe Healthcare, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
  it_behaves_like 'a record that updates the escort on save'
  it { is_expected.to have_many(:medications) }

  it do
    is_expected.to accept_nested_attributes_for(:medications).
      allow_destroy(true)
  end

  describe '#backfilled_medications' do
    let(:array_size) { 6 }
    let(:klass) { MedicationForm }

    context 'when there are no persisted medication models' do
      it 'returns a fixed size array of empty medications' do
        subject.medications.destroy_all

        expect(subject.backfilled_medications).
          to satisfy do |meds|
            meds.size == array_size &&
              meds.all? { |m| m.is_a?(Medication) } &&
              meds.none?(&:persisted?)
          end
      end
    end

    context 'when there are some persisted medication models' do
      it 'returns an array of the models padded with empty medications' do
        subject.save
        subject.medications.destroy_all
        2.times { subject.medications.create }

        expect(subject.backfilled_medications).
          to satisfy do |meds|
            meds.size == array_size &&
              meds.count(&:persisted?) == 2 &&
              meds.all? { |m| m.is_a?(Medication) }
          end
      end
    end
  end
end
