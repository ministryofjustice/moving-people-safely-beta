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
    it 'generates the correct HTML code' do
      travel_to(Date.new(2015, 2, 3)) do
        expect(html).to have_content('Person Escort Record - cover sheet').
          and have_content('Family name Bigglesworth').
          and have_content('Forenames Tarquin').
          and have_content('Date of birth 13 2 1972').
          and have_content('Age 42').
          and have_content('Sex M').
          and have_content('Prison number A1234BC').
          and have_content('Nationality British').
          and have_content('Attach photo').
          and have_content('Not for release').
          and have_content('Reason')
      end
    end
  end
end
