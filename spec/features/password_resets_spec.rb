require 'rails_helper'

RSpec.feature 'password resets', type: :feature do
  scenario 'resetting a password' do
    create_user('person@prison.com', 'secret123')

    visit new_user_password_path
    fill_in 'user[email]', with: 'person@prison.com'
    click_button 'Reset password'

    token = devise_token_from_last_mail(:reset_password)
    visit edit_user_password_path(reset_password_token: token)

    new_password = 'newpass123'
    fill_in 'user[password]', with: new_password
    fill_in 'user[password_confirmation]', with: new_password
    click_button 'Change my password'

    expect(current_path).to eq root_path
  end
end
