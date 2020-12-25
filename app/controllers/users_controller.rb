class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
       redirect_to user_path(@user.id), notice: 'You have updated userinfomation successfully.'
    else
      render "edit"
    end
  end

  def index
    @users = User.all
    @user = User.find_by(id: current_user)
    @book = Book.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # before_action
  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) if current_user != @user
  end

end