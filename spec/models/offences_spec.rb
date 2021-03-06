require 'rails_helper'

RSpec.describe Offences, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
  it_behaves_like 'a record that updates the escort on save'
  it { is_expected.to have_many(:offence_details) }

  it do
    is_expected.to accept_nested_attributes_for(:offence_details).
      allow_destroy(true)
  end

  describe '#backfilled_offence_details' do
    let(:array_size) { 6 }
    let(:klass) { OffenceDetailsForm }

    context 'when there are no persisted offence details models' do
      it 'returns a fixed size array of empty offence_details' do
        subject.offence_details.destroy_all

        expect(subject.backfilled_offence_details).
          to satisfy do |offence_details|
            offence_details.size == array_size &&
              offence_details.all? { |m| m.is_a?(OffenceDetails) } &&
              offence_details.none?(&:persisted?)
          end
      end
    end

    context 'when there are some persisted offence details models' do
      it 'returns an array of the models padded with empty offence_details' do
        subject.save
        subject.offence_details.destroy_all
        2.times { subject.offence_details.create }

        expect(subject.backfilled_offence_details).
          to satisfy do |offence_details|
            offence_details.size == array_size &&
              offence_details.count(&:persisted?) == 2 &&
              offence_details.all? { |m| m.is_a?(OffenceDetails) }
          end
      end
    end
  end
end
