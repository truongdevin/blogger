class CommentsController < ApplicationController
  
  before_filter :zero_authors_or_authenticated, except: [:create]
  def zero_authors_or_authenticated
    unless Author.count == 0 || current_user
      redirect_to root_path
      return false
    end
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    
    @comment.save
    
    redirect_to article_path(@comment.article)
  end
  
  def comment_params
    params.require(:comment).permit(:author_name, :body)
  end
end
