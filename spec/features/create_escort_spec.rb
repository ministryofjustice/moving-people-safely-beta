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
  end
end
