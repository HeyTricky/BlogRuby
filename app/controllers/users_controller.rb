class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all.paginate(page: params[:page], :per_page => 4)
  end
 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
      flash[:success] = "Добавлен новый пользователь"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], :per_page => 3)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user      
      flash[:success] = "Данные о пользователе были успешно изменены"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def set_moderator
    @user = User.find(params[:id])
    @user.set_moderator
    @user.save
    redirect_to @user
  end

  def set_user
    @user = User.find(params[:id])
    @user.set_user
    @user.save
    redirect_to @user
  end
  private 
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
end