module PdfStylesheetBuilder
module_function

  STYLESHEETS_ASSET_PATH = 'app/assets/stylesheets'
  PDF_STYLESHEET_NAME = 'pdf.css'

  def html_safe_pdf_stylesheet
    Rails.env.production? ? STYLESHEET : build
  end

  def build
    environment = Sprockets::Environment.new
    environment.append_path(STYLESHEETS_ASSET_PATH)
    environment[PDF_STYLESHEET_NAME].to_s.html_safe
  end

  private_class_method :build

  STYLESHEET = build
end
