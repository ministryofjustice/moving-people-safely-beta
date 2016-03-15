require 'rails_helper'

RSpec.feature 'managing an escorts healthcare', type: :feature do
  let(:link_name)                 { 'Healthcare' }
  let(:healthcare_field_category) { 'Physical health risks' }
  let(:healthcare_field_text)     { 'Broken leg' }

  scenario 'adding a healthcare field without details' do
    start_escort_form
    click_link link_name
    fill_in_healthcare_field healthcare_field_category, 'Yes', nil
    click_save

    expect(page).to have_content 'There were problems saving the form'
  end

  scenario 'removing a healthcare field using the clearing option' do
    start_escort_form
    click_link link_name
    fill_in_healthcare_field healthcare_field_category,
      'Yes', healthcare_field_text
    click_save

    within_healthcare_field(healthcare_field_category) do
      expect(page).to have_content healthcare_field_text
      clear_healthcare_field healthcare_field_category
    end

    click_save

    within_healthcare_field(healthcare_field_category) do
      expect(page).not_to have_content healthcare_field_text
    end
  end

  scenario 'removing a healthcare field by selecting no' do
    start_escort_form
    click_link link_name
    fill_in_healthcare_field healthcare_field_category,
      'Yes', healthcare_field_text
    click_save

    within_healthcare_field(healthcare_field_category) do
      expect(page).to have_content healthcare_field_text
      choose 'No'
    end

    click_save

    within_healthcare_field(healthcare_field_category) do
      expect(page).not_to have_content healthcare_field_text
    end
  end
end
