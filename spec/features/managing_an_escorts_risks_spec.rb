require 'rails_helper'

RSpec.feature 'managing an escorts risks', type: :feature do
  let(:link_name)     { 'Risks' }
  let(:risk_category) { 'Risks to self' }
  let(:risk_text)     { 'Risky business' }

  scenario 'adding a risk without details' do
    start_escort_form
    click_link link_name
    fill_in_risk risk_category, 'Yes', nil
    click_save

    expect(page).to have_content 'There were problems saving the form'
  end

  scenario 'removing a risk using the clearing option' do
    start_escort_form
    click_link link_name
    fill_in_risk risk_category, 'Yes', risk_text
    click_save

    within_risk(risk_category) do
      expect(page).to have_content risk_text
      clear_risk risk_category
    end

    click_save

    within_risk(risk_category) do
      expect(page).not_to have_content risk_text
    end
  end

  scenario 'removing a risk by selecting no' do
    start_escort_form
    click_link link_name
    fill_in_risk risk_category, 'Yes', risk_text
    click_save

    within_risk(risk_category) do
      expect(page).to have_content risk_text
      choose 'No'
    end

    click_save

    within_risk(risk_category) do
      expect(page).not_to have_content risk_text
    end
  end
end
