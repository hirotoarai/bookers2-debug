class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end
  
  def create
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Signed in successfully."
      redirect_to user_path(@user)
    else
      flash[:notice] = "error"
      render :index
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "error"
      render :edit
    end
  end
  
  def followed
    @user = User.find(params[:id])
    @users = @user.followeds
    render :followed
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render :followers
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
