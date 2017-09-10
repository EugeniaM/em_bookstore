class ApplicationMailer < ActionMailer::Base
  default from: 'maltsevae88@gmail.com'
  # layout 'mailer'

  def welcome_email(user, psw)
    @user = user
    @psw = psw
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Bookstore')
  end
end
