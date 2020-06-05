class UsersController < ApplicationController
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      redirect_to root_url
      flash[:success] = 'ユーザーの登録に成功しました。'
    else
      render :new
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
end
