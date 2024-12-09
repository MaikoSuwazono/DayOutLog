class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:post_details).where(status: 1).order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: t('.success')
    else 
      flash.now[:danger] = t('.failure')
      render :new, status: :unprocessable_entity, success: 
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path, success: "ユーザーを更新しました"
    else
      render :edit, danger: "ユーザーの更新に失敗しました"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
