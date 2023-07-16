class BooksController < ApplicationController

 def create
  @user = current_user
  @book = Book.new(book_params)
  @book.user_id = @user.id
  @books = @user.books

  if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    render :index
  end
 end


 def index
  @user = current_user
  @books = Book.all
  @book = Book.new

 end

  def show
   @user = current_user
   @book = Book.find(params[:id])
  end


  def edit
    @book = Book.find(params[:id])
  if @book.user_id != current_user.id
    redirect_to books_path, notice: "You are not authorized to edit this book."
  end
  end



  def update

    @book = Book.find(params[:id])
   if @book.update(book_params)
    redirect_to @book, notice: "Book was successfully updated."
   else
    render :edit
   end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end


 private

 def book_params
  params.require(:book).permit(:title, :body, :user_id)
 end
end