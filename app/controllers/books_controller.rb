class BooksController < ApplicationController
     before_action :authenticate_user!

  def index
  @user=current_user
  @new_book=Book.new
  @books = Book.all.order(id: :desc)
  end


  def create
  @new_book=Book.new(book_params)
  @new_book.user_id=current_user.id
  if @new_book.save
  redirect_to book_path(@new_book.id),notice: "You have creatad book successfully."
  else
  @user= current_user
  @books = Book.all.order(id: :desc)
  flash[:alert]="error can't be blank"
  render :index
  end
  end

  def show
  @book = Book.find(params[:id])
  @user=User.find_by(id: @book.user_id)
  @new_book=Book.new
  end

  def edit
  @book=Book.find(params[:id])
  if current_user.id == @book.user_id
  @book=Book.find(params[:id])
  else
  redirect_to books_path
  end
  end

  def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
  redirect_to book_path(@book),notice: "You have updated book successfully."
  else
  flash[:alert]="error can't be blank"
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

end
