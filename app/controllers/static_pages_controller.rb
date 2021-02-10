class StaticPagesController < ApplicationController

  def home
    @articles = Article.all.includes(:user, :favorites)
    @all_ranks = Article.unscoped.includes(:user).find(Favorite.includes(:article).group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end

  def email
  end
end