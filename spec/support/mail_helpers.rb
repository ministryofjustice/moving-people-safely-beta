module MailHelpers
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def devise_token_from_last_mail(token_name)
    last_email.body.to_s[/#{token_name}_token=([^"]+)/, 1]
  end
end
