RSpec::Matchers.define :be_a_pdf do
  PDF_START_BYTE = 0
  PDF_END_BYTE = 4
  # see: https://en.wikipedia.org/wiki/List_of_file_signatures
  PDF_SIGNATURE = '%PDF'

  match do |file|
    file[PDF_START_BYTE, PDF_END_BYTE] == PDF_SIGNATURE
  end

  failure_message { 'the file does not appear to be a PDF' }
end
