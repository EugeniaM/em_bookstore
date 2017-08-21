class BooksController < ApplicationController
  def index
    @books = Book.where(nil)
    @books = Book.filter(params.slice(:category, :custom_sort)).page(params[:page] || 1)
    @order_item = current_order.order_items.new if current_user
    @order_item = current_order.guest_order_items.new if !current_user

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @book = Book.find(params[:id])
    @main_cover = @book.covers[0]
    @book_imgs = @book.covers.slice(1, @book.covers.size)
    @qty = 1
    @order_item = current_order.order_items.new if current_user
    @order_item = current_order.guest_order_items.new if !current_user
    @reviews_list = !!params[:reviews]
    respond_to do |format|
      format.js
      format.html
    end
  end
end
