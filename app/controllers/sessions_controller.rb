class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: sessions[:params][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])

    else
      flash[:danger] = 'ログインに失敗しました'
    end
  end

  def destroy

  end
end