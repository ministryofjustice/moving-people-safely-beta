require 'rails_helper'

RSpec.feature 'completing digital person escort record', type: :feature do
  around(:each) do |example|
    travel_to(Date.new(2015, 2, 3)) { example.run }
  end

  scenario 'start a person escort record' do
    start_escort_form
    expected_path = %r{ /escort/#{TestHelper::UUID_REGEX}/prisoner }x

    expect(current_path).to match expected_path
  end

  scenario 'leaving the current PER in order to start another' do
    start_escort_form
    click_button 'Save'

    click_link 'Find a prisoner'
    expect(current_path).to eq root_path
  end

  scenario 'filling in the prisoner prisoner page' do
    start_escort_form

    expect(page).to have_heading 'Prisoner Information'

    expect(page).to have_preview_per_link
    expect(page).to have_find_prisoner_link

    fill_in_prisoner

    expect(page).
      to have_content 'Escort record updated successfully'
  end

  scenario 'filling in the risks page' do
    start_escort_form
    click_link 'Risks'

    expect(page).to have_heading 'Risks'

    expect(page).to have_preview_per_link
    expect(page).to have_find_prisoner_link

    fill_in_risks

    expect(page).
      to have_content 'Escort record updated successfully'
  end

  scenario 'filling in the move page' do
    start_escort_form
    click_link 'Move Information'

    expect(page).to have_heading 'Move Information'

    expect(page).to have_preview_per_link
    expect(page).to have_find_prisoner_link

    fill_in_move

    expect(page).
      to have_content 'Escort record updated successfully'
  end

  scenario 'filling in the healthcare page' do
    start_escort_form
    click_link 'Healthcare'

    expect(page).to have_heading 'Healthcare'

    expect(page).to have_preview_per_link
    expect(page).to have_find_prisoner_link

    fill_in_healthcare

    expect(page).
      to have_content 'Escort record updated successfully'
  end

  scenario 'filling in the offences page' do
    start_escort_form
    click_link 'Offences'

    expect(page).to have_heading 'Offences'

    expect(page).to have_preview_per_link

    fill_in_offences

    expect(page).
      to have_content 'Escort record updated successfully'
  end

  scenario 'viewing the summary of an escort' do
    start_escort_form
    fill_in_prisoner
    click_link 'Risks'
    fill_in_risks
    click_link 'Move Information'
    fill_in_move
    click_link 'Summary'

    expect(page).to have_heading 'Summary'

    expect(page).to have_preview_per_link
    expect(page).to have_find_prisoner_link

    expect(page).to have_text('Prisoner Information').
      and have_link('Edit', href: prisoner_path(escort)).
      and have_content('Family name Bigglesworth').
      and have_content('Forenames Tarquin').
      and have_content('Date of birth 13/02/1972').
      and have_content('Age 42').
      and have_content('Sex M').
      and have_content('Nationality British').
      and have_content('Prison number A1234BC').
      and have_content('CRO number SOMECRO').
      and have_content('PNC number SOMEPNC')

    expect(page).to have_text('Summary').
      and have_link('Edit', href: move_path(escort)).
      and have_content('From HMP Clive House').
      and have_content('To Petty France').
      and have_content('Date of travel 03/02/2015').
      and have_content('Reason for move (current offence) ' \
        'Expected to attend show the thing')
  end
end
