require 'rails_helper'

RSpec.feature 'completing digital person escort record', type: :feature do
  scenario 'logging into the application' do
    visit root_path
    expect(current_path).to eq new_user_session_path

    login
    expect(current_path).to eq root_path
  end

  scenario 'session timeout in 60 minutes' do
    login
    travel_to(1.hour.from_now) do
      visit root_path
      expect(current_path).to eq new_user_session_path
    end
  end
end
