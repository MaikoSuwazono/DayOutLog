class PostDetailsController < ApplicationController
  def index
    @post_details = PostDetail.all.includes(:post).order(arrival_at: :asc)
  end

  def new
    @post = Post.find(params[:post_id])
    @post_details = @post.post_details.order(arrival_at: :asc)
    @post_detail = PostDetail.new
  end

  def create
    @post_detail = PostDetail.new(post_detail_params)
    @post = @post_detail.post
  
    if @post_detail.save
      @post_details = @post_detail.post.post_details.order(arrival_at: :asc)
      @post_detail = PostDetail.new

      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: '行き先が追加されました。' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('post_details', partial: 'post_details/form', locals: { post_detail: @post_detail }) }
      end
    end
  end
  
  def update; end

  def show
    @post_detail = PostDetail.find(params[:id])
  end

  def destroy
    @post_detail = PostDetail.find(params[:id])
    @post_detail.destroy!

    @post_details = @post_detail.post.post_details.order(arrival_at: :asc)

    respond_to do |format|
      format.html { redirect_to post_path(@post_detail.post), notice: '行き先が削除されました。' }
      format.turbo_stream
    end
  end

  def publish
    @post = Post.find(params[:post_id])
    @post.status = 1

    if @post.save
      redirect_to post_path(@post), success: "記事が投稿されました"
    else
      flash.now[:danger] = "記事の投稿に失敗しました"
      render :preview, status: :unprocessable_entity
    end
  end

  private

  def post_detail_params
    params.require(:post_detail).permit(:body, :arrival_at, :image, :image_cache, :address, :latitude, :longitude).merge(post_id: params[:post_id])
  end
end
