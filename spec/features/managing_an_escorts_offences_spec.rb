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
end
