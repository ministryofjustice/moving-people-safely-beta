require 'rails_helper'

RSpec.feature 'create a new digital person escort record', type: :feature do
  context 'along the happy path' do
    scenario 'start a person escort record' do
      visit '/'
      click_button 'Create new escort record'
      expected_path = %r{
        /escort/
        #{TestHelper::UUID_REGEX}
        /identification
      }x

      expect(current_path).to match expected_path
    end

    describe 'add identification data' do
      context 'when all the required fields are present' do
        it 'shows a success message' do
          visit '/'
          click_button 'Create new escort record'

          fill_in 'Prison number', with: 'ab1234xy'
          fill_in 'Family name', with: 'Black'
          fill_in 'Forenames', with: 'John'
          choose 'Male'
          fill_in 'identification[date_of_birth][day]', with: '12'
          fill_in 'identification[date_of_birth][month]', with: '03'
          fill_in 'identification[date_of_birth][year]', with: '2016'
          fill_in 'Nationality', with: 'American'
          fill_in 'PNC number', with: 'xyz123abc'
          fill_in 'CRO number', with: 'def987jkl'
          fill_in 'Family name', with: 'John'
          click_button 'Save'

          expect(page).
            to have_content 'Identification data updated successfully'
        end
      end

      context 'when there are missing fields' do
        it 'shows an error message' do
          visit '/'
          click_button 'Create new escort record'
          click_button 'Save'

          expect(page).to have_content 'There were problems saving the form'
          expect(page).to have_content "Prison number can't be blank"
          expect(page).to have_content 'Sex is not included in the list'
        end
      end
    end
  end
end
