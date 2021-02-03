class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]

  def index
    @user = current_user
    @favorite_articles = @user.favorites.map{ |favorite| favorite.article }
    @articles = Kaminari.paginate_array(@favorite_articles).page(params[:page]).per(8)
  end

  def create
    @favorite = current_user.favorites.build(article_id: params[:article_id])
    @favorite.save
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:article_id])
    @favorite.destroy
    redirect_back(fallback_location: root_url)
  end
end