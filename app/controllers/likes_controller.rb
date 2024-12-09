class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: @post.id)
    @like.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post_id: @post.id)
    @like.destroy!
  end

  def show
    @user = current_user
    @likes = Like.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.find(@likes)
  end
end
