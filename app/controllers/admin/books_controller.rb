class Admin::BooksController < Admin::BaseController

  helper_method :sort_column, :sort_direction

  before_filter :find_book, :only => [:edit, :update, :show, :destroy]

  def index
    @q = Book.search(params[:q])
    @books = find_books
  end


  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_books_path, :notice => "Successfully created book."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @book.update_attributes(book_params)
      redirect_to admin_books_path, :notice => "Successfully updated book."
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to admin_books_path, :notice => "Book deleted."
  end

  protected

  def find_book
    @book = Book.find(params[:id])
  end

  def find_books
    search_relation = @q.result
    @books = search_relation.order(sort_column + " " + sort_direction).references(:book).page params[:page]
  end

  def sort_column
    Book.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title,:url,:cover_url,:description,:publisher)
  end

end
