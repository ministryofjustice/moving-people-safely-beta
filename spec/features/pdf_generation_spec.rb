require 'rails_helper'

RSpec.feature 'PDF generation for an escort', type: :feature do
  scenario 'viewing an escort records PDF' do
    escort = create(:escort)
    visit pdf_path(escort)

    expect(response_headers['Content-Type']).to eq 'application/pdf'
    expect(response_headers['Content-Disposition']).to eq 'inline'
  end
end
