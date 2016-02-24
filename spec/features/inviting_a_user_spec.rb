require 'rails_helper'

RSpec.feature 'inviting a user', type: :feature do
  scenario 'user accepts an invitation' do
    step = InvitationStep.new
    step.invite_user
    step.user_clicks_invitation_link

    invalid_password = '123123'
    step.set_password invalid_password

    expect(page).to have_content 'Password is too short'

    valid_password = 'Berty2016'
    step.set_password valid_password

    expect(current_path).to eq root_path
  end
end