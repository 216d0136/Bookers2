class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book, only: [:edit, :update]
  def index
  	  @books = Book.all
  	  @book = Book.new
      @user = current_user
  end

  def show
      @user = current_user
  	  @book = Book.find(params[:id])
      @book_new = Book.new

  end

  def new
      @book = Book.new
  end

  def create
      @user = current_user
  	  @book = Book.new(book_params)
      @book.user_id = current_user.id
  	  if @book.save
        flash[:notice] = "successfully"
  	  	 redirect_to book_path(@book.id)
  	  else
  	  	 @books = Book.all
  	  	 render 'index'
  	  end
  end

  def edit
  		@book = Book.find(params[:id])
  end
  def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
         flash[:notice] = "successfully"
         redirect_to book_path(@book.id)
      else
        render 'edit'
      end
  end
  def destroy
      book = Book.find(params[:id])
        book.destroy
        flash[:notice] = "successfully"
        redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
 def correct_book
     book = Book.find(params[:id])
     unless current_user == book.user
      redirect_to books_path
    end
 end
end
