require 'rails_helper'

RSpec.feature 'password resets', type: :feature do
  scenario 'resetting a password' do
    start_password_reset

    token = devise_token_from_last_mail(:reset_password)
    visit edit_user_password_path(reset_password_token: token)

    change_password('newpass123')

    expect(current_path).to eq root_path
  end
end
