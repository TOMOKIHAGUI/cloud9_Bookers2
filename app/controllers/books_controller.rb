class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @user = User.find_by(id: current_user)
    @new_book = Book.new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
      if @new_book.save
         redirect_to book_path(@book.id), notice: 'You have created book successfully.'
      else
        @user = User.find_by(id: current_user)
        @books = Book.all
        render "index"
      end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @comment = BookComment.new
  end

  def edit
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render "edit"
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
      redirect_to books_path if current_user != @book.user
    end

end
