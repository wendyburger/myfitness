class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = '你已經成功登入'
      redirect_to home_path
    else
      flash[:error] = '錯誤的email或密碼'
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "你已經成功登出"
    redirect_to home_path
  end
end