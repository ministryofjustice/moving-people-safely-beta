require 'rails_helper'

RSpec.feature 'managing an escorts offences', type: :feature do
  let(:link_name)                 { 'Offences' }
  let(:offences_field_category)   { 'Not for release' }
  let(:offences_field_text)       { 'Not ready' }

  scenario 'adding a offences field without details' do
    start_escort_form
    click_link link_name
    fill_in_offences_field offences_field_category, 'Yes', nil
    click_save

    expect(page).to have_content 'There were problems saving the form'
  end

  scenario 'removing a offences field using the clearing option' do
    start_escort_form
    click_link link_name
    fill_in_offences_field offences_field_category,
      'Yes', offences_field_text
    click_save

    within_offences_field(offences_field_category) do
      expect(page).to have_content offences_field_text
      clear_offences_field offences_field_category
    end

    click_save

    within_offences_field(offences_field_category) do
      expect(page).not_to have_content offences_field_text
    end
  end

  scenario 'removing a offences field by selecting no' do
    start_escort_form
    click_link link_name
    fill_in_offences_field offences_field_category,
      'Yes', offences_field_text
    click_save

    within_offences_field(offences_field_category) do
      expect(page).to have_content offences_field_text
      choose 'No'
    end

    click_save

    within_offences_field(offences_field_category) do
      expect(page).not_to have_content offences_field_text
    end
  end

  scenario 'removing a nested offence details' do
    start_escort_form
    click_link link_name
    fill_in_offences
    remove_offence_details

    offence_details_0 =
      find_field('offences[offence_details[0]][offence_type]').value
    offence_details_1 =
      find_field('offences[offence_details[1]][offence_type]').value

    expect(offence_details_0).to eq 'Burglary'
    expect(offence_details_1).to eq nil
  end
end
