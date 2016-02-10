require 'rails_helper'

RSpec.feature 'Summary page for an escort' do
  scenario 'viewing an escort records overview' do
    travel_to(Date.new(2015, 2, 3)) do
      start_escort_form
      fill_in_identification

      visit summary_path(Escort.last)

      expect(page).to have_text('Summary').
        and have_text('Prisoner Information').
        and have_link('Edit', href: identification_path(Escort.last)).
        and have_content('Family name Bigglesworth').
        and have_content('Forename(s) Tarquin').
        and have_content('Date of birth 13/02/1972').
        and have_content('Age 42').
        and have_content('Sex M').
        and have_content('Nationality British').
        and have_content('Prison number A1234BC')
    end
  end
end
