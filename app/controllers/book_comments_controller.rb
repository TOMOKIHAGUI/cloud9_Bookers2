class BookCommentsController < ApplicationController

  def create
    @any_book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @any_book.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @any_book = Book.find(params[:book_id])
    comment = @any_book.book_comments.find(params[:id])
    if comment.user != current_user
      redirect_back(fallback_location: root_path)
    end
    comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end