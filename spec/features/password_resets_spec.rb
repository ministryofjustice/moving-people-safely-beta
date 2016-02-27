require 'rails_helper'

RSpec.feature 'password resets', type: :feature do
  scenario 'resetting a password' do
    create_user('person@prison.com', 'secret123')
    visit new_user_password_path
    fill_in 'user[email]', with: 'person@prison.com'
    click_button 'Reset password'
    visit edit_user_password_path(reset_password_token: reset_password_token)
    fill_in 'user[password]', with: 'newpass123'
    fill_in 'user[password_confirmation]', with: 'newpass123'
    click_button 'Change my password'
    expect(current_path).to eq root_path
  end
end
