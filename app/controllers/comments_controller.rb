class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    @comments = @comment.post.comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    @comments = @comment.post.comments.includes(:user).order(created_at: :desc)
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post) }
      format.turbo_stream
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
