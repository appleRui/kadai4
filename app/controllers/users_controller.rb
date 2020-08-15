class UsersController < ApplicationController
     before_action :authenticate_user!


  def index
  @user=current_user
  @users = User.all.order(id: :desc)
  @new_book=Book.new
  end

  def show
  	@user=User.find(params[:id])
    @new_book=Book.new
    @books=@user.books.all
  end

  def create
  @new_book=Book.new(book_params)
  @new_book.user_id=current_user.id
  if @new_book.save
  redirect_to books_path,notice: "You have creatad user successfully."
  else
  flash[:alert]="error can't be blank"
  render books_path
  end
  end

  def edit
  @user = User.find(params[:id])
  if current_user.id == @user.id
  @user = User.find(params[:id])
  else
  redirect_to user_path(current_user)
  end
  end

  def update
  @user = User.find(params[:id])
  if @user.update(user_params)
  redirect_to user_path(@user.id),notice: "You have updated book successfully."
  else
  flash[:alert]="error can't be blank"
  render :edit
  end
  end

  private
  def user_params
  params.require(:user).permit(:name,:profile_image, :introduction)
  end

  def book_params
  params.require(:book).permit(:title, :body)
  end

end
