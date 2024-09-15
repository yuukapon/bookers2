# "Bookers2" Book
class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def new
    @book_new = Book.new
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @books = Book.page(params[:page])
      @user = current_user
      render :index
    end
  end

  def index
    @book_new = Book.new
    @books = Book.page(params[:page])
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated the book successfully."
    else
      render :edit
    end
  end
  
  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "Book was successfully deleted."
    else
      flash[:notice] = "Failed to delete the book."
    end
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  
  def is_matching_login_user
    user = Book.user.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
  def is_matching_login_user
      user = Book.find(params[:id]).user  # 本を投稿したユーザーを取得
    unless user.id == current_user.id
      redirect_to books_path       # ユーザーが不一致ならリダイレクト
    end
  end

end
