class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to email_path
    else
      flash.now[:danger] = "そのメールアドレスは存在しません"
      render 'new'
    end
  end

  def edit
  end
end
