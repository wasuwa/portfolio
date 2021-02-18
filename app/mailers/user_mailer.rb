class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => 'パスワードをリセットします') do |format|
      format.text
    end
  end
end
