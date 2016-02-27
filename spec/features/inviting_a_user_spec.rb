require 'rails_helper'

RSpec.feature 'inviting a user', type: :feature do
  let(:step) { InvitationStep.new }

  scenario 'user accepts an invitation' do
    step.invite_user
    step.user_clicks_invitation_link

    invalid_password = '123123'
    step.set_password invalid_password

    expect(page).to have_content 'Password is too short'

    valid_password = 'Berty2016'
    step.set_password valid_password

    expect(current_path).to eq root_path
  end

  scenario 'invitation token does not exist' do
    step.user_clicks_invitation_link token: 'gibberish'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'invitation token expires after 3 days' do
    invite_user('person@prison.com')
    travel_to(4.days.from_now) do
      step.user_clicks_invitation_link
      expect(current_path).to eq new_user_session_path
    end
  end
end
