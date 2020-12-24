class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @user = User.find_by(id: current_user)
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
         redirect_to book_path(@book.id), notice: 'You have created book successfully.'
      else
        @user = User.find_by(id: current_user)
        @books = Book.all
        render :index
      end
  end

  def show
    @book = Book.new
    @any_book = Book.find(params[:id])
    @user = @any_book.user
  end

  def edit
  end

  def update
    if @book.update(book_params)
       redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

    def book_params
      params.require(:book).permit(:title, :body)
    end

    # before_action
    def correct_user
      @book = Book.find(params[:id])
      redirect_to root_url if current_user != @book.user
    end

end
