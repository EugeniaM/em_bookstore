class HomeController < ApplicationController  
  def index
    @last_added_books = Book.last(3)
    @best_sellers = Book.find_by_sql("SELECT * FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY sum DESC) AS Row_ID FROM (SELECT books.*, sum(order_items.quantity) FROM books JOIN order_items ON order_items.book_id = books.id JOIN orders ON orders.id = order_items.order_id WHERE orders.order_status_id > 1 GROUP BY books.id) AS B) AS A WHERE Row_ID < 2 ORDER BY category_id;")
    puts "!!!!!!!!!!!!!!!"
    puts @best_sellers
    puts "!!!!!!!!!!!!!!!"
    @order_item = current_order.order_items.new if current_user
    @order_item = current_order.guest_order_items.new if !current_user
  end
end
