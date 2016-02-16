require 'rails_helper'

RSpec.feature 'searching for a prisoner', type: :feature do
  around(:each) do |example|
    travel_to(Date.new(2015, 2, 3)) { example.run }
  end

  context 'with a valid prison number' do
    context 'when prison number is not present' do
      scenario 'shows no results' do
        visit '/'
        fill_in_prison_number 'Z9876XY'
        click_button 'Search'
        expect(page).to have_content 'There are no previously created PERs ' \
          'for prisoner number Z9876XY'
      end
    end

    context 'when prison number is present' do
      scenario 'shows the prisoner with a link to edit the PER' do
        start_escort_form
        fill_in_identification
        visit '/'
        fill_in_prison_number 'A1234BC'
        click_button 'Search'
        expect(page).to have_link('A1234BC', href: summary_path(Escort.last)).
          and have_content('Bigglesworth, Tarquin 13/02/1972 00:00 03/02/2015')
      end
    end
  end

  context 'with an invalid prison number' do
    scenario 'shows an error message' do
      visit '/'
      fill_in_prison_number 'invalid_prison_number'
      click_button 'Search'
      expect(page).to have_content 'Enter a valid prison number'
    end
  end
end
