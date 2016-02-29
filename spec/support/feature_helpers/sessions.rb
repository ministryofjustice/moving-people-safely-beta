module FeatureHelpers
  module Sessions
    def login
      create :user
      visit root_path
      fill_in 'user[email]', with: attributes_for(:user)[:email]
      fill_in 'user[password]', with: attributes_for(:user)[:password]
      click_button 'Log in'
    end

    def sign_out
      click_button 'Sign out'
    end

    def invite_user
      email = attributes_for(:user)[:email]
      User.invite!(email: email)
    end

    # rubocop:disable AccessorMethodName
    def set_password(password)
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_button 'Set my password'
    end

    def start_password_reset
      create :user
      visit new_user_password_path
      fill_in 'user[email]', with: attributes_for(:user)[:email]
      click_button 'Reset password'
    end

    def change_password(new_password)
      fill_in 'user[password]', with: new_password
      fill_in 'user[password_confirmation]', with: new_password
      click_button 'Change my password'
    end
  end
end
