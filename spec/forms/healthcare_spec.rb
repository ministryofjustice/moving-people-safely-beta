require 'rails_helper'

RSpec.describe Healthcare, type: :form do
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
    medication_details: 'some text',
    medical_professional_name: 'Donald Trump',
    contact_telephone: '02022223333'
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

  it_behaves_like 'a form that syncs to a model',
    input_attributes, coercion_overrides

  it_behaves_like 'a form that retrives or builds its target',
    :health_information

  it_behaves_like 'a form that knows what template to render',
    'healthcare'

  it_behaves_like 'a form that belongs to an endpoint',
    'healthcare'

  toggle_fields = %i[ physical_risk mental_risk
                      social_care_and_other allergies
                      disabilities medication ]
  it_behaves_like 'a form with a text toggle attribute',
    toggle_fields

  subject { described_class.new(create :escort) }

  def self.falsey_combinations
    possible_attribute_values = [true, false, nil]
    possible_attribute_values.
      product(possible_attribute_values).
      reject { |a, b| a && b }
  end

  describe '#mpv_required' do
    context 'depends on the value of the disabilities attribute' do
      falsey_combinations.each do |mpv_required_value, disabilities_value|
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
