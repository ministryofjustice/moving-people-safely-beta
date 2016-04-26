require 'rails_helper'

RSpec.describe OffencesForm, type: :form do
  subject { described_class.new(create :escort) }

  offence_details_attributes = {
    '0' => {
      offence_type: 'Bulgary',
      offence_status: 'outstanding_charge',
      not_for_release: true,
      current_offence: true,
      _destroy: nil
    },
    '1' => {
      offence_type: '',
      offence_status: '',
      not_for_release: nil,
      current_offence: nil,
      _destroy: nil
    },
    '2' => {
      offence_type: '',
      offence_status: '',
      not_for_release: nil,
      current_offence: nil,
      _destroy: true
    }
  }

  input_attributes = {
    not_for_release: 'true',
    not_for_release_details: 'some text',
    must_return: 'false',
    must_return_details: 'some text',
    must_not_return: nil,
    must_not_return_details: 'some text',
    offence_details: offence_details_attributes
  }

  coercion_overrides = {
    not_for_release: true,
    must_return: false,
    must_return_details: nil,
    must_not_return: nil,
    must_not_return_details: nil
  }

  describe 'coercing inputs' do
    it_behaves_like 'a form that coerces attributes',
      input_attributes.except(:offence_details),
      coercion_overrides

    describe 'nested medication items' do
      it 'coerces params from a request into offence details forms' do
        subject.
          assign_attributes(offence_details: offence_details_attributes)

        expect(subject.offence_details).
          to be_a_collection_of(OffenceDetailsForm).
          of_size(3).
          satisfy do |collection|
            collection.first.offence_type == 'Bulgary'
          end
      end
    end
  end

  it_behaves_like 'a form that retrives or builds its target', :offences
  it_behaves_like 'a form that knows what template to render', 'offences'
  it_behaves_like 'a form that belongs to an endpoint', 'offences'
  it_behaves_like 'a form with a text toggle attribute',
    %i[ not_for_release must_return must_not_return ]

  describe '#initialize' do
    it 'loads a models attributes into the form' do
      model_attrs = subject.target.attributes.with_indifferent_access
      form_attrs = subject.attributes.except(:offence_details)

      expect(model_attrs).to include form_attrs
    end
  end

  describe '#save' do
    before { subject.assign_attributes(input_attributes) }

    it 'passes the forms data to the underlying model' do
      filled_offence_details = [
        {
          id: nil,
          offence_type: 'Bulgary',
          offence_status: 'outstanding_charge',
          not_for_release: true,
          current_offence: true,
          _destroy: nil
        }
      ]
      attributes_with_hashed_offence_details = coercion_overrides.merge(
        offence_details_attributes: filled_offence_details)

      expect(subject.target).to receive(:update_attributes).
        with(
          hash_including(
            input_attributes.
              except(:offence_details).
              merge(attributes_with_hashed_offence_details))
        )

      subject.save
    end

    it 'returns true' do
      expect(subject.save).to be true
    end
  end
end
