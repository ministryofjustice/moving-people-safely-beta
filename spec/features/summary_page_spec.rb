require 'rails_helper'

RSpec.feature 'Summary page for an escort' do
  scenario 'viewing an incomplete escort' do
    escort = Escort.create(prison_number: 'A1234BC')

    visit summary_path(escort)

    expect(page).to have_text('Summary').
      and have_text('Prisoner Information').
      and have_link('Edit', href: identification_path(escort)).
      and have_content('Family name Not entered yet').
      and have_content('Forename(s) Not entered yet').
      and have_content('Date of birth Not entered yet').
      and have_content('Sex Not entered yet').
      and have_content('Nationality Not entered yet').
      and have_content('Prison number A1234BC')
  end

  scenario 'viewing a completed escort' do
    escort = Escort.create(
      family_name: 'Bigglesworth',
      forenames: 'Tarquin',
      date_of_birth: Date.new(1972, 2, 13),
      sex: 'male',
      prison_number: 'A1234BC',
      nationality: 'British'
    )

    visit summary_path(escort)

    expect(page).to have_text('Summary').
      and have_text('Prisoner Information').
      and have_link('Edit', href: identification_path(escort)).
      and have_content('Family name Bigglesworth').
      and have_content('Forename(s) Tarquin').
      and have_content('Date of birth 13/02/1972').
      and have_content('Sex M').
      and have_content('Nationality British').
      and have_content('Prison number A1234BC')
  end
end
