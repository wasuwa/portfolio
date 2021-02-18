class SessionsController < ApplicationController
  before_action :logged_in_user, :only => [:destroy]

  def new
  end

  def create
    user = User.find_by(:email => params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインに成功しました'
      redirect_back_or user
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトに成功しました'
    redirect_to root_path
  end
end
