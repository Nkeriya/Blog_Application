class ArticlesController < ApplicationController
  before_action :set_user
  before_action :set_id, except: [:index, :archived, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @articles = Article.all
  end

  def archived
    @articles= Article.all
    @count = @articles.archived_count
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article #{@article.title} has been created!"
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article #{@article.title} has been updated!"
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article #{@article.title} has been deleted!"
    redirect_to articles_path
  end

  private
  def set_user
    @user = User.find_by(params[:email])
  end

  def set_id
    @article = Article.find(params[:id])
  end

  def article_params
    params.required(:article).permit(:title, :text, :status, :user_id)
  end
end 