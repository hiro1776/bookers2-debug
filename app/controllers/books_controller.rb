class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user,{only: [:edit, :update, :destroy]}
  def show
  	@book = Book.find(params[:id])
    @user = current_user
    @book_new = Book.new
  end

  def index
  	@books = Book.all
    @book = Book.new #一覧表示するためにBookモデルの情報を全てくださいのall
    @user = current_user
    @users =User.all
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
      flash[:notice] = "successfully created book!"
  		redirect_to book_path(@book.id) #保存された場合の移動先を指定。
  	else
  		@books = Book.all
      @user = current_user
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
        flash[:notice] = "successfully updated book!"
  		redirect_to book_path(@book.id)
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render 'edit'
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	if @book.destroy
      flash[:notice] = "successfully delete book!"
      redirect_to books_path
    end
  end
  private
  def book_params
      params.require(:book).permit(:title, :body)
    end

  def ensure_current_user
      @book=Book.find_by(id: params[:id])
      if @book.user_id != current_user.id
        redirect_to books_path
      end
    end

end
