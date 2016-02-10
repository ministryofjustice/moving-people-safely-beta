require 'rails_helper'

RSpec.feature 'create a new digital person escort record', type: :feature do
  context 'along the happy path' do
    scenario 'start a person escort record' do
      start_escort_form
      expected_path = %r{
        /escort/
        #{TestHelper::UUID_REGEX}
        /identification
      }x

      expect(current_path).to match expected_path
    end

    describe 'add identification details' do
      context 'when all the required fields are present' do
        it 'shows a success message' do
          start_escort_form
          fill_in_identification
          expect(page).
            to have_content 'Escort record updated successfully'
        end
      end

      context 'when there are missing fields' do
        it 'shows an error message' do
          start_escort_form
          click_button 'Save'

          expect(page).to have_content 'There were problems saving the form'
          expect(page).to have_content "Prison number can't be blank"
        end
      end
    end
  end
end
