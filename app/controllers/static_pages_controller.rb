class StaticPagesController < ApplicationController

  def home
    @articles = Article.all
  end

  def favorite_list
  end

  def email
  end
end
