class SessionsController < ApplicationController
  
  
  def new
  end
  
  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email,password)
      redirect_to root_url
      flash[:success] = 'ログイン成功しました。'
    else
      render :new
      flash[:danger] = 'ログイン失敗しました。'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
    flash[:success] = 'ログアウトしました。'
  end
  
  private
  
  def login(email,password)
    @user = User.find_by(email:email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
