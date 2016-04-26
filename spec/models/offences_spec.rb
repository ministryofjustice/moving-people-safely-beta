require 'rails_helper'

RSpec.describe Offences, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
  it_behaves_like 'a record that updates the escort on save'

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

    context 'when offence details forms are passed in' do
      it 'returns an array of form objects padded with empty model objects' do
        offence_details_forms = Array.new(2) { OffenceDetailsForm.new }

        expect(subject.backfilled_offence_details(offence_details_forms)).
          to satisfy do |offence_details|
            offence_details.size == array_size &&
              offence_details.count(&:persisted?) == 0 &&
              offence_details.count { |m| m.is_a?(OffenceDetailsForm) } == 2 &&
              offence_details.count { |m| m.is_a?(OffenceDetails) } == 4
          end
      end
    end
  end
end
