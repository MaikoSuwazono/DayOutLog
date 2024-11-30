class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:post_details).where(status: 1).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to new_post_post_detail_path(@post), success: "記事が作成されました"
    else
      flash.now[:danger] = "記事の作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_details = @post.post_details.order(:arrival_at)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: "記事が削除されました", status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :departure_date, :image, post_details_attributes: [:id, :body, :arrival_at, :image, :address, :latitude, :longitude])
  end

  def set_search_object
    @q = Post.ransack(params[:q])
  end
end
