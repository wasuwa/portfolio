class StaticPagesController < ApplicationController

  def home
    @articles = Article.all
  end

  def email
  end
end
