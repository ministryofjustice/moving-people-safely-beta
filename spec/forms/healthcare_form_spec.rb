require 'rails_helper'

RSpec.describe HealthcareForm, type: :form do
  subject { described_class.new(create :escort) }

  medications_attributes = {
    '0' => {
      description: 'Aspirin',
      administration: 'Once a day',
      carrier: 'prisoner',
      _destroy: nil
    },
    '1' => {
      description: '',
      administration: '',
      carrier: '',
      _destroy: nil
    },
    '2' => {
      description: '',
      administration: '',
      carrier: '',
      _destroy: true
    }
  }

  input_attributes = {
    physical_risk: 'true',
    physical_risk_details: 'some text',
    mental_risk: 'false',
    mental_risk_details: 'some text',
    social_care_and_other: 'unknown',
    social_care_and_other_details: 'some text',
    allergies: 'true',
    allergies_details: 'some text',
    disabilities: 'true',
    mpv_required: 'true',
    disabilities_details: 'some text',
    medication: 'true',
    medical_professional_name: 'Donald Trump',
    contact_telephone: '02022223333',
    medications: medications_attributes
  }

  coercion_overrides = {
    physical_risk: true,
    mental_risk: false,
    mental_risk_details: nil,
    social_care_and_other: nil,
    social_care_and_other_details: nil,
    allergies: true,
    disabilities: true,
    mpv_required: true,
    medication: true
  }

  describe 'coercing inputs' do
    it_behaves_like 'a form that coerces attributes',
      input_attributes.except(:medications),
      coercion_overrides

    describe 'nested medication items' do
      it 'coerces params from a request into medication items' do
        subject.
          assign_attributes(medications: medications_attributes)

        expect(subject.medications).
          to be_a_collection_of(MedicationForm).
          of_size(3).
          and satisfy { |collection| collection.first.description == 'Aspirin' }
      end
    end
  end

  it_behaves_like 'a form that retrives or builds its target', :healthcare
  it_behaves_like 'a form that knows what template to render', 'healthcare'
  it_behaves_like 'a form that belongs to an endpoint', 'healthcare'
  it_behaves_like 'a form with a text toggle attribute',
    %i[ physical_risk mental_risk social_care_and_other allergies disabilities ]

  describe '#initialize' do
    it 'loads a models attributes into the form' do
      model_attrs = subject.target.attributes.with_indifferent_access

      # Medication attributes is used on the form due to the fields_for
      # helper but is not a property of the target so we need to remove it.
      form_attrs =
        subject.attributes.
        with_indifferent_access.
        except(:medications)

      expect(model_attrs).to include form_attrs
    end
  end

  describe '#save' do
    before { subject.assign_attributes(input_attributes) }

    it 'passes the forms data to the underlying model' do
      filled_medications = [
        {
          id: nil,
          description: 'Aspirin',
          administration: 'Once a day',
          carrier: 'prisoner',
          _destroy: nil
        }
      ]
      attributes_with_hashed_medications = coercion_overrides.merge(
        medications_attributes: filled_medications)

      expect(subject.target).to receive(:update_attributes).
        with(
          hash_including(
            input_attributes.
              except(:medications).
              merge(attributes_with_hashed_medications))
        )

      subject.save
    end

    it 'returns true' do
      expect(subject.save).to be true
    end

    context 'with medications' do
      context 'when medication is true' do
        it 'saves the medication(s), discarding empties on the target' do
          subject.assign_attributes(medication: 'true')
          subject.medications = medications_attributes
          subject.save

          expect(subject.target.medications.size).to be 1
        end
      end

      %w[ false unknown ].each do |falsey_medication_value|
        context "when the medication is set to #{falsey_medication_value}" do
          before do
            subject.assign_attributes(medication: falsey_medication_value)
            subject.medications = medications_attributes
          end

          it 'resets empty medications' do
            subject.save
            expect(subject.medications.all?(&:empty?)).to be true
          end

          it 'destroys existing medications' do
            2.times { subject.target.medications.build }
            subject.target.save

            expect { subject.save }.
              to change { subject.target.medications.count }.
              from(2).to(0)
          end
        end
      end
    end
  end

  def self.falsey_permutations
    possible_attribute_values = [true, false, nil]
    possible_attribute_values.repeated_permutation(2).to_a - [[true, true]]
  end

  describe '#mpv_required' do
    context 'depends on the value of the disabilities attribute' do
      falsey_permutations.each do |mpv_required_value, disabilities_value|
        context "when mpv_required is a #{mpv_required_value.class}" do
          context "when disabilities is a #{disabilities_value.class}" do
            it 'returns a falsey value' do
              subject.mpv_required = mpv_required_value
              subject.disabilities = disabilities_value

              expect(subject.mpv_required).to be_falsey
            end
          end
        end
      end

      context 'when mpv_required is set to true' do
        context 'when disabilities is set to true' do
          it 'returns true' do
            subject.mpv_required = true
            subject.disabilities = true

            expect(subject.mpv_required).to be true
          end
        end
      end
    end
  end
end
