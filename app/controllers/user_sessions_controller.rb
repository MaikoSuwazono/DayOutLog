class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  include UserSessionsHelper

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      params[:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or_to posts_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path, success: t('.success'), status: :see_other
  end
end
