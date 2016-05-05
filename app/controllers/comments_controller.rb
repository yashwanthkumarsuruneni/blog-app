class CommentsController < ApplicationController
#to provide security to several authorised actions on comments

# method to add a comment on an article
  def create
    @article = Article.where(id: params[:article_id]).first
    @comment =@article.comments.create(comment_params)
    @comment.Commentor_Id=current_user.id
    @comment.save
    redirect_to article_path(@article)
  end
#method to delete a comment on article
  def destroy
     @article = Article.where(id: params[:article_id]).first
     @comment = @article.comments.where(id :params[:id]).first
     if @comment.Commentor_Id===current_user.id
        @comment.destroy
        redirect_to article_path(@article)
     else
      redirect_to article_path(@article), :alert => "You are not authorised to delete this comment!"
     end
  end
 
 
private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
