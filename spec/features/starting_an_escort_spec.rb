require 'rails_helper'

RSpec.feature 'starting an escort', type: :feature do
  around(:each) do |example|
    travel_to(Date.new(2015, 2, 3)) { example.run }
  end

  context 'with a valid prison number' do
    context 'when the prison number does not already exist' do
      it 'allows the user to initiate a new escort' do
        visit '/'
        fill_in_prison_number 'Z9876XY'
        click_button 'Search'
        expect(page).to have_content 'There are no previously created PERs ' \
          'for prisoner number Z9876XY'
        click_button 'Initiate new PER'
        expect(page).to have_content 'Z9876XY'
        expect(current_path).to eq identification_path(Escort.last)
      end
    end

    context 'when the prison number is exists' do
      it 'allows the user to edit an existing escort by clicking a link' do
        start_escort_form
        fill_in_identification
        visit '/'
        fill_in_prison_number 'A1234BC'
        click_button 'Search'
        expect(page).to have_link('A1234BC', href: summary_path(Escort.last)).
          and have_content('Bigglesworth, Tarquin 13/02/1972 00:00 03/02/2015')
      end

      context 'the prison number has been persisted in another session' do
        it 'redirects to the home page' do
          visit '/'
          fill_in_prison_number 'Z9876XY'
          click_button 'Search'
          # simulate creation of an escort with the same prison number
          # elsewhere (e.g by another user)
          create(:escort, :with_prisoner, prison_number: 'Z9876XY')
          click_button 'Initiate new PER'
          expect(current_path).to eq root_path
        end
      end
    end
  end

  context 'with an invalid prison number' do
    it 'shows an error message' do
      visit '/'
      fill_in_prison_number 'invalid_prison_number'
      click_button 'Search'
      expect(page).to have_content 'Enter a valid prison number'
    end
  end
end
