class PdfsController < ApplicationController
  def show
    pdf = PdfGenerator.for(escort)
    send_data pdf, type: 'application/pdf', disposition: 'inline'
  end
end
