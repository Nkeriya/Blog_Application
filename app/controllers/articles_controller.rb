class ArticlesController < ApplicationController
  before_action :correct_user, only: [:update, :destroy]
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
    # @article = Article.new
    @article = current_user.articles.build
  end

  def create
    # @article = Article.new(article_params)

    @article = current_user.articles.build(article_params)
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

  def correct_user
    unless current_user.admin
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to articles_path, notice: "You are not authorized to perform this action!!" if @article.nil?
    end
  end

  def set_id
    @article = Article.find(params[:id])
  end

  def article_params
    params.required(:article).permit(:title, :text, :status, :user_id)
  end
end 