require 'rails_helper'

RSpec.feature 'create an escort record', type: :feature do

  context 'along the happy path' do
    context 'clicking the create button on the index page' do
      it 'sends the user to the identification page' do
        visit '/'
        click_button 'Create new escort record'
        expected_path = %r{
          /escort-record/
          #{TestHelper::UUID_REGEX}
          /identification
        }x

        expect(current_path).to match expected_path
      end
    end
  end
end
