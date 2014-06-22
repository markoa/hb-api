require 'spec_helper'

describe Admin::BooksController do

  def mock_book(stubs={})
    (@mock_book ||= mock_model(Book).as_null_object).tap do |book|
      stubs.each_key do |method_name|
        allow(book).to receive(method_name).and_return(stubs[method_name])
      end
    end
  end

  before { allow(controller).to receive(:require_admin) }

  describe "GET index" do
    it "assigns all books as @books" do
      allow(controller).to receive(:find_books).and_return([mock_book])
      get :index
      expect(assigns(:books)).to eq([mock_book])
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      allow(Book).to receive(:find).with("37") { mock_book }
      get :show, :id => "37"
      expect(assigns(:book)).to be(mock_book)
    end
  end

  
  describe "GET new" do
    it "assigns a new book as @book" do
      allow(Book).to receive(:new) { mock_book }
      get :new
      expect(assigns(:book)).to be(mock_book)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created book as @book" do
        allow(Book).to receive(:new).with({'these' => 'params'}) { mock_book(:save => true) }
        post :create, :book => {'these' => 'params'}
        expect(assigns(:book)).to be(mock_book)
      end

      it "redirects to the created book" do
        allow(Book).to receive(:new) { mock_book(:save => true) }
        post :create, :book => {}
        expect(response).to redirect_to(admin_books_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        allow(Book).to receive(:new).with({'these' => 'params'}) { mock_book(:save => false) }
        post :create, :book => {'these' => 'params'}
        expect(assigns(:book)).to be(mock_book)
      end

      it "re-renders the 'new' template" do
        allow(Book).to receive(:new) { mock_book(:save => false) }
        post :create, :book => {}
        expect(response).to render_template("new")
      end
    end

  end
  
  
  describe "GET edit" do
    it "assigns the requested book as @book" do
      allow(Book).to receive(:find).with("37") { mock_book }
      get :edit, :id => "37"
      expect(assigns(:book)).to be(mock_book)
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested book" do
        expect(Book).to receive(:find).with("37") { mock_book }
        expect(mock_book).to receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :book => {'these' => 'params'}
      end

      it "assigns the requested book as @book" do
        allow(Book).to receive(:find) { mock_book(:update_attributes => true) }
        put :update, :id => "1"
        expect(assigns(:book)).to be(mock_book)
      end

      it "redirects to the book" do
        allow(Book).to receive(:find) { mock_book(:update_attributes => true) }
        put :update, :id => "1"
        expect(response).to redirect_to(admin_books_url)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        allow(Book).to receive(:find) { mock_book(:update_attributes => false) }
        put :update, :id => "1"
        expect(assigns(:book)).to be(mock_book)
      end

      it "re-renders the 'edit' template" do
        allow(Book).to receive(:find) { mock_book(:update_attributes => false) }
        put :update, :id => "1"
        expect(response).to render_template("edit")
      end
    end

  end
  
  describe "DELETE destroy" do
    it "destroys the requested book" do
      expect(Book).to receive(:find).with("37") { mock_book }
      expect(mock_book).to receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the books list" do
      allow(Book).to receive(:find) { mock_book }
      delete :destroy, :id => "1"
      expect(response).to redirect_to(admin_books_url)
    end
  end

end

