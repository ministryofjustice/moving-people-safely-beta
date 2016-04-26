require 'rails_helper'

RSpec.describe OffencesForm, type: :form do
  subject { described_class.new(create :escort) }

  offence_details_attributes = {
    '0' => FactoryGirl.build(:offence_details_attributes),
    '1' => FactoryGirl.build(:offence_details_attributes, :empty),
    '2' => FactoryGirl.build(:offence_details_attributes, :mark_for_destroy)
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

    describe 'nested offence details items' do
      it 'coerces params from a request into offence details forms' do
        subject.
          assign_attributes(offence_details: offence_details_attributes)

        expect(subject.offence_details).
          to be_a_collection_of(OffenceDetailsForm).
          of_size(3).
          and satisfy { |collection| collection[0].offence_type == 'Burglary' }
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
      filled_offence_details_attributes = [
        FactoryGirl.build(:offence_details_attributes),
        FactoryGirl.build(:offence_details_attributes, :mark_for_destroy)
      ]
      attrs = subject.attributes.merge(
        offence_details_attributes: filled_offence_details_attributes
      )
      attrs.delete(:offence_details)

      expect(subject.target).to receive(:update_attributes).with(attrs)

      subject.save
    end

    it 'returns true' do
      expect(subject.save).to be true
    end
  end
end
