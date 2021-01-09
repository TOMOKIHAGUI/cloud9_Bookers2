class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
      if @comment.save
        render :comment
      else
        @user = @book.user
        render 'books/show'
      end
  end

  def destroy
    @book = Book.find(params[:book_id])
    comment = @book.book_comments.find(params[:id])
    comment.destroy
    render :comment
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id, :user_id)
  end

end