require 'rails_helper'

RSpec.describe PdfStylesheetBuilder, type: :service do
  describe '.html_safe_pdf_stylesheet' do
    context 'in production environment' do
      it 'invokes build method only once at run time' do
        allow(Rails.env).to receive(:production?).and_return(true)
        expect(described_class).not_to receive(:build)
        2.times { described_class.html_safe_pdf_stylesheet }
      end
    end

    context 'in all other environments' do
      it 'invokes build method each time is called' do
        allow(Rails.env).to receive(:production?).and_return(false)
        expect(described_class).to receive(:build).twice
        2.times { described_class.html_safe_pdf_stylesheet }
      end
    end
  end
end
