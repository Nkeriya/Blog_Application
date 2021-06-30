class CommentsController < ApplicationController
  before_action :set_article_id
  before_action :set_id, except: :create 
  before_action :authenticate_user!
  before_action :correct_user, only: [:update, :destroy]
  
  def create
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
  end

  def edit
  end

  def update
      @comment.update(comment_params)
      redirect_to article_path(@article)
  end

  def destroy
      @comment.destroy
      redirect_to article_path(@article)
  end

  private
  def set_article_id
      @article = Article.find(params[:article_id])
  end

  def set_id
      @comment = @article.comments.find(params[:id])
  end

  def correct_user
    unless current_user.admin
        @comment = current_user.comments.find_by(id: params[:id])
        redirect_to articles_path, notice: "You are not authorized to perform this action!!" if @comment.nil?
    end
  end

  def comment_params
      params.require(:comment).permit(:commenter, :body, :user_id)
  end
end