class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  if @book.save
   redirect_to book_path(@book), notice: "You have created book successfully."
  else
   @user = current_user
   @books = Book.all
   render "index"
  end
end

  def show
    @book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

 def edit
  @book = Book.find(params[:id])
  unless @book.user == current_user
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
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    redirect_to books_path # 投稿一覧画面へリダイレクト
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
