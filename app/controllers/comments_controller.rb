class CommentsController < ApplicationController
  before_action :logged_in_user, :only => [:create, :destroy]
  before_action :get_comments

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.find_by(:user_id => current_user.id, :article_id => @article.id, :id => params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def get_comments
    @comments = Article.find(params[:article_id]).comments
  end
end
