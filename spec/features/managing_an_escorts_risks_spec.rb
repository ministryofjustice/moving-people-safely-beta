require 'rails_helper'

RSpec.feature 'managing an escorts risks', type: :feature do
  let(:risk_category) { 'Violence and risk to others' }
  let(:risk_text)     { 'Risky business' }

  before(:each) { go_to_risks_page }

  scenario 'adding a risk without details' do
    fill_in_risk risk_category, 'Yes', nil
    click_save

    expect(page).to have_content 'There were problems saving the form'
  end

  scenario 'removing a risk using the clearing option' do
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
    fill_in_risk risk_category, 'Yes', risk_text
    click_save

    within_risk(risk_category) do
      expect(page).to have_content risk_text
      choose_first_radio 'No'
    end

    click_save

    within_risk(risk_category) do
      expect(page).not_to have_content risk_text
    end
  end

  context 'within the Risks to self section' do
    let(:open_acct_section) { 'Does the prisoner have an open ACCT?' }
    let(:risk_category) { 'Risks to self' }

    scenario 'managing whether a person has an open acct' do
      fill_in_risk risk_category, 'Yes', risk_text
      within_risk(open_acct_section) { choose 'Yes' }
      click_save

      within_risk(open_acct_section) do
        expect(find_field('Yes')).to be_checked
      end

      within_risk(risk_category) { choose_first_radio 'No' }
      click_save

      # if the wrapper toggle is not true it clears out the acct radio
      within_risk(open_acct_section) do
        expect(find_field('Yes')).not_to be_checked
      end
    end
  end

  def go_to_risks_page
    start_escort_form
    click_link 'Risks'
  end
end
