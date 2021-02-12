class ArticlesController < ApplicationController
  before_action :logged_in_user, :only => [:create, :destroy, :new, :update, :edit]
  before_action :correct_user, :only => :destroy

  def index
    @articles = Article.all.includes(:user, :favorites).page(params[:page])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    @user = current_user
    if @article.save
      flash[:success] = "投稿に成功しました"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @article = Article.find(params[:id])
    @user = @article.user
    @comment = Comment.new
    @comments = @article.comments.all.includes(:user)
    @not_current_articles = @user.articles.includes(:favorites).reject { |article| article == @article }
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.image = nil if params[:article][:image_delete_value]
    if @article.update(article_params)
      flash[:success] = "記事の更新に成功しました"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @user = current_user
    @article.destroy
    flash[:success] = "記事が削除されました"
    redirect_back(:fallback_location => @user)
  end

  private

    def article_params
      params.require(:article).permit(:content, :title, :image)
    end

    def correct_user
      @article = current_user.articles.find_by(:id => params[:id])
      redirect_to @user if @article.nil?
    end
end