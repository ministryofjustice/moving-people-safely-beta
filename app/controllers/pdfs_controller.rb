class PdfsController < ApplicationController
  def show
    # pdf = PdfGenerator.for(escort)
    html = cell('pdf/main', escort).render
    pdf = PDFKit.new(html).to_pdf
    send_data pdf, type: 'application/pdf', disposition: 'inline'
  end
end
