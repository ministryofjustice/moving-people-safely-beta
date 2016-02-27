require 'rails_helper'

RSpec.feature 'inviting a user', type: :feature do
  scenario 'user accepts an invitation' do
    invite_user

    token = devise_token_from_last_mail(:invitation)
    visit accept_user_invitation_path(invitation_token: token)

    invalid_password = '123123'
    set_password invalid_password
    expect(page).to have_content 'Password is too short'

    valid_password = attributes_for(:user)[:password]
    set_password valid_password
    expect(current_path).to eq root_path
  end

  scenario 'invitation token does not exist' do
    visit accept_user_invitation_path(invitation_token: 'gibberish')
    expect(current_path).to eq new_user_session_path
  end

  scenario 'invitation token expires after 3 days' do
    invite_user
    travel_to(4.days.from_now) do
      token = devise_token_from_last_mail(:invitation)
      visit accept_user_invitation_path(invitation_token: token)
      expect(current_path).to eq new_user_session_path
    end
  end
end
