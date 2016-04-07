require 'rails_helper'

RSpec.describe Pdf::FrontPageMarkersPresenter, type: :presenter do
  let(:escort) do
    create(:escort, :with_healthcare, :with_risks)
  end

  subject { described_class.new(escort) }

  let(:possible_checkbox_values) { [true, false, nil] }

  def checkbox_presenter_instance(attribute, value)
    Pdf::CoversheetCheckboxGroup.new(attribute, value)
  end

  context 'healthcare markers' do
    %i[ allergies disabilities ].each do |checkbox|
      it 'returns a configured CoversheetCheckboxGroup instance' do
        possible_checkbox_values.each do |attribute_value|
          escort.healthcare.public_send("#{checkbox}=", attribute_value)

          expect(subject.public_send(checkbox)).
            to eq checkbox_presenter_instance(checkbox, attribute_value)
        end
      end
    end
  end

  context 'risks markers' do
    %i[ open_acct violence escape non_association ].each do |checkbox|
      it 'returns a configured CoversheetCheckboxGroup instance' do
        possible_checkbox_values.each do |attribute_value|
          escort.risks.public_send("#{checkbox}=", attribute_value)

          expect(subject.public_send(checkbox)).
            to eq checkbox_presenter_instance(checkbox, attribute_value)
        end
      end
    end
  end
end
