class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @article = Article.find_by(id: params[:id])
    @comment = current_user.comments.build(article_id: params[:article_id])
    @comment.save
    redirect_back(fallback_location: @article)
  end

  def destroy
  end
end
