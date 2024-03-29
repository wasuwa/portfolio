class PasswordResetsController < ApplicationController
  before_action :get_user,   :only => [:edit, :update]
  before_action :valid_user, :only => [:edit, :update]
  before_action :check_expiration, :only => [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(:email => params[:password_reset][:email].downcase)
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

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードが更新されました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(:email => params[:email])
  end

  def valid_user
    unless @user&.authenticated?(:reset, params[:id])
      flash[:danger] = "無効なリンクです"
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "URLの有効期限が切れています"
      redirect_to password_resets_url
    end
  end
end
