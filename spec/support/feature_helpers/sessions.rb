module FeatureHelpers
  module Sessions
    def login
      email = 'person@prison.com'
      password = 'secret123'
      create_user(email, password)
      visit root_path
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      click_button 'Log in'
    end

    def create_user(email, password)
      create(
        :user,
        email: email,
        password: password,
        password_confirmation: password
      )
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
  end
end
