class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: @article)
    else
      redirect_to @article, flash: { comment_error: @comment.errors.full_messages }
    end
  end

  def destroy
  end

  private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
