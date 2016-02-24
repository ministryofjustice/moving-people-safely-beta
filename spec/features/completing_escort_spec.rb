require 'rails_helper'

RSpec.feature 'completing digital person escort record', type: :feature do
  around(:each) do |example|
    travel_to(Date.new(2015, 2, 3)) { example.run }
  end

  scenario 'start a person escort record' do
    start_escort_form
    expected_path = %r{
      /escort/
      #{TestHelper::UUID_REGEX}
      /identification
    }x

    expect(current_path).to match expected_path
  end

  scenario 'filling in the prisoner identification page' do
    start_escort_form

    expect(page).to have_heading 'Prisoner Information'

    fill_in_identification

    expect(page).
      to have_content 'Escort record updated successfully'
  end

  scenario 'filling in the risks page' do
    start_escort_form
    fill_in_identification
    click_link 'Risks'

    expect(page).to have_heading 'Risks'

    fill_in_risks

    expect(page).
      to have_content 'Escort record updated successfully'
  end

  scenario 'vieiwing the summary of an escort' do
    start_escort_form
    fill_in_identification
    click_link 'Risks'
    fill_in_risks
    click_link 'Summary'

    expect(page).to have_heading 'Summary'

    expect(page).to have_text('Prisoner Information').
      and have_link('Edit', href: identification_path(Escort.last)).
      and have_content('Family name Bigglesworth').
      and have_content('Forenames Tarquin').
      and have_content('Date of birth 13/02/1972').
      and have_content('Age 42').
      and have_content('Sex M').
      and have_content('Nationality British').
      and have_content('Prison number A1234BC').
      and have_content('CRO number SOMECRO').
      and have_content('PNC number SOMEPNC')
  end
end
