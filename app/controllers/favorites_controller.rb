class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    user = current_user
    favorite = Favorite.new(user_id: user.id, book_id: @book.id)
    favorite.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    user = current_user
    favorite = Favorite.find_by(user_id: user.id, book_id: @book.id)
    favorite.destroy
  end

  private
  
  def set_favorite
    @book = Book.find(params[:book_id])
  end

end
