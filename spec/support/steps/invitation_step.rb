class InvitationStep
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def invite_user
    @user = User.invite!(email: 'user@prison.com')
    @token = @user.raw_invitation_token
  end

  def user_clicks_invitation_link(token: @token)
    visit accept_user_invitation_path(invitation_token: token)
  end

  # rubocop:disable AccessorMethodName
  def set_password(password)
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    click_button 'Set my password'
  end
end
