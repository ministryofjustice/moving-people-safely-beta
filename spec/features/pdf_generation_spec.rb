require 'rails_helper'

RSpec.feature 'PDF generation for an escort', type: :feature do
  scenario 'viewing an escort records PDF' do
    start_escort_form
    visit pdf_path(Escort.last)

    expect(response_headers['Content-Type']).to eq 'application/pdf'
    expect(response_headers['Content-Disposition']).to eq 'inline'
  end
end
