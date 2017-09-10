class HomeController < ApplicationController  
  def index
    @last_added_books = Book.last(3)
    @best_sellers = @best_sellers = Book.find_by_sql("SELECT * FROM 
      (SELECT *, ROW_NUMBER() OVER (PARTITION BY category_id order by order_counter DESC) AS Row_ID FROM books) AS A
      WHERE Row_ID < 2 ORDER BY category_id")
    @order_item = current_order.order_items.new if current_user
    @order_item = current_order.guest_order_items.new if !current_user
  end
end
