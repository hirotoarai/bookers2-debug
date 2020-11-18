class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = BookComment.new
    @user = User.find(@book.user_id)
    @favorite = Favorite.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @favorite = Favorite.new
  end
  
  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @books = Book.all
      @user = current_user
      flash[:notice] = 'error'
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
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

end
