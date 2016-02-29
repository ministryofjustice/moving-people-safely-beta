require 'rails_helper'

RSpec.feature 'User sessions', type: :feature do
  scenario 'logging into the application' do
    visit root_path
    expect(current_path).to eq new_user_session_path

    login
    expect(current_path).to eq root_path
  end

  scenario 'session timeout after 1 hour' do
    login

    travel_to(1.hour.from_now) do
      visit root_path
      expect(current_path).to eq new_user_session_path
    end
  end

  scenario 'signing out' do
    login
    expect(current_path).to eq root_path

    sign_out
    expect(current_path).to eq new_user_session_path

    visit root_path
    expect(current_path).to eq new_user_session_path
  end
end
