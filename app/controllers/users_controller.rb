class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index,:show]
  
  def index
    @users = User.all.order(id: :desc).page(params[:page]).per(3)
  end

  def show
    @user = User.find(params[:id])
  end

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
