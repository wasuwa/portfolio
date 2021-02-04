class StaticPagesController < ApplicationController

  def home
    @articles = Article.all
    @all_ranks = Article.unscoped.find(Favorite.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end

  def email
  end
end
