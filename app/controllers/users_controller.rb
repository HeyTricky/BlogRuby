class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
      flash[:success] = "Welcome to the blog Fludilka"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(user_params)
    if @user.update(user_params)
      redirect_to @user
      flash[:success] = "Ваши данные были успешно изменены"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private 
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
end