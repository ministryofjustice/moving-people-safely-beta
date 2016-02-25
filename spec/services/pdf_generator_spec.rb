require 'rails_helper'

RSpec.describe PdfGenerator, type: :service do
  include Capybara::RSpecMatchers

  let(:escort) { create(:escort, :with_prisoner) }

  describe '.for' do
    it 'uses PDFKit library' do
      pdfkit = instance_double('PDFKit', to_pdf: 'PDF code')
      expect(PDFKit).to receive(:new).and_return(pdfkit)
      described_class.for(escort)
    end
  end

  describe '.render' do
    let(:html) { described_class.render(escort) }
    it 'generates the expected content for the header' do
      expect(html).to have_content('Person Escort Record')
    end
    it 'generates the expected content for NFR section' do
      expect(html).to have_content('Not for release').
        and have_content('Reason')
    end
    it 'generates the expected content for move information section' do
      expect(html).to have_content('From').
        and have_content('To').
        and have_content('Date of travel').
        and have_content('Destination update')
    end
    it 'generates the expected content for personal information section' do
      travel_to(Date.new(2015, 2, 3)) do
        expect(html).to have_content('Family name Bigglesworth').
          and have_content('Forenames Tarquin').
          and have_content('Date of birth 13 2 1972').
          and have_content('Age 42').
          and have_content('Sex M').
          and have_content('Prison number A1234BC').
          and have_content('Nationality British').
          and have_content('Attach photo')
      end
    end
    it 'generates the expected content for the updates section' do
      expect(html).to have_content('Include relevant updates').
        and have_content('and heightened risks from section B3')
    end
    it 'generates the expected content for the risk updates section' do
      expect(html).to have_content('Risk updates').
        and have_content('Include relevant updates').
        and have_content('and heightened risks from section B3').
        and have_content('Tick if SASH has been opened')
    end
    it 'generates the expected content for the risk summary section' do
      expect(html).to have_content('A2. Risk summary').
        and have_content('PNC / Prison number').
        and have_content('Risks to self').
        and have_content('Violence and risk to others').
        and have_content('Risk from others').
        and have_content('Escort escape risk').
        and have_content('Intolerant behaviour towards others').
        and have_content('Prohibited items').
        and have_content('Non-association').
        and have_content('Date of incident').
        and have_content('Name of person filling in this section').
        and have_content('Signature')
    end
    it 'generates the expected content for the healthcare section' do
      expect(html).to have_content('A3. Healthcare information').
        and have_content('Physical health risks').
        and have_content('Mental health risks').
        and have_content('Social care needs and other healthcare needs').
        and have_content('Allergies').
        and have_content('Disabilities').
        and have_content('Tick if MPV required').
        and have_content('Medication').
        and have_content('Medication handover details in').
        and have_content('section B1: Record of handover').
        and have_content('Medication description').
        and have_content('Medication administration information').
        and have_content('Name of medical professional').
        and have_content('filling in this section').
        and have_content('Contact phone number').
        and have_content('Updates').
        and have_content('This section should be').
        and have_content('completed by a medical professional')
    end
    it 'generates the expected content for the offences section' do
      expect(html).to have_content('A4. Offences').
        and have_content('See A1. Cover sheet for details of current offence').
        and have_content('Other offences').
        and have_content('Use an offence status from the following list').
        and have_content('Outstanding charge').
        and have_content('Serving sentence').
        and have_content('On remand').
        and have_content('License recall').
        and have_content('Offence').
        and have_content('Offence status')
    end
    it 'generates the expected content for the handover details section' do
      expect(html).to have_content('B1. Handover details').
        and have_content('Fit to travel').
        and have_content('Name of healthcare professional (print)').
        and have_content('Signature').
        and have_content('Role')
    end
  end
end
