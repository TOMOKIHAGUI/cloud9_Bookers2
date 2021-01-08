class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    @user_or_book = params[:option]
    @how_search = params[:choice]
    @word = params[:word]
    if @user_or_book == "1"
      @users = User.search(@word, @how_search)
    elsif @user_or_book == "2"
      @books = Book.search(@word, @how_search)
    end
  end

end
