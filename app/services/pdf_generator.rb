module PdfGenerator
  PDF_TEMPLATE_PATH = 'pdfs/show'

module_function

  def for(escort)
    html = render(escort)
    PDFKit.new(html).to_pdf
  end

  def render(model)
    # TODO: To be refactored when Rails 5 will come out
    # see article: http://goo.gl/ONThkT
    ActionController::Base.new.
      render_to_string(
        PDF_TEMPLATE_PATH,
        locals: { escort: Pdf::EscortPresenter.new(model) }
      )
  end
end
