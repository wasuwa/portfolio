class UsersController < ApplicationController
  before_action :logged_in_user, :only => [:edit, :update]
  before_action :correct_user, :only => [:edit, :update]
  before_action :not_user, :only => [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "新規登録が完了しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.icon = nil if params[:user][:icon_delete_value]
    if @user.update(user_params)
      flash[:success] = "プロフィールの更新に成功しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :grade, :password,
                                 :password_confirmation, :icon)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?
      flash[:danger] = "他のユーザーのプロフィールは編集できません"
      redirect_to(root_url)
    end
  end

  def not_user
    @url = request.url
    @end_of_url = File.basename(@url)
    unless User.find_by(id: @end_of_url).present?
      flash[:danger] = "そのユーザーは存在しません"
      redirect_to root_url
    end
  end
end
