class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]
#  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      session[:user_id] = @user.id
      flash[:success] = 'ユーザ情報を編集しました'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザ情報の編集に失敗しました'
      render :new
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'ユーザを削除しました'
    redirect_to root_path
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path if @user != current_user
  end
end
