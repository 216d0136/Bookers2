class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  def index
  		@users = User.all
      @book = Book.new
      @user = current_user
  end

  def show
  		@book = Book.new
      @user = User.find(params[:id])
      @books = @user.books
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = 'successfully'
        redirect_to user_path(@user)

      else
         @users = User.all
         render 'edit'
      end
  end
private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
    def correct_user
    @user = User.find(params[:id])
     unless current_user.id == @user.id
      redirect_to current_user
    end
  end

end
