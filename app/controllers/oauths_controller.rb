class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if @user = login_from(provider)
      redirect_to posts_path, success: t('.success')
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to posts_path, success: t('.success')
      rescue
        redirect_to root_path, danger: t('.failure')
      end
    end
  end
  
  private

  def auth_params
    params.permit(:code, :provider)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
