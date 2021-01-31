class StaticPagesController < ApplicationController

  def home
    @articles = Article.all
  end

  def other_profile
  end

  def new_articles_list
  end

  def favorite_list
  end
end
