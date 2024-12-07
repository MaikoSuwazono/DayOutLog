class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def show
    @user = current_user
    @posts = current_user.posts.includes(:post_details).where(status: 1).order(created_at: :desc)
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
