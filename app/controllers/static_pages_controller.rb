class StaticPagesController < ApplicationController

  def home
    @articles = Article.all
  end

  def password_setting
  end

  def other_profile
  end

  def new_articles_list
  end

  def favorite_list
  end

  def article_details
  end
  
  def my_article_details
  end

  def email
    
  end
end
