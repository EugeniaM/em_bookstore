class HomeController < ApplicationController  
  def index
    @last_added_books = Book.last(3)
    @best_sellers = Book.find_by_sql("select * from 
      (select *, ROW_NUMBER() OVER (PARTITION BY category_id order by sum DESC) AS Row_ID 
      FROM (select books.*, sum(order_items.quantity) 
      FROM books join order_items on order_items.book_id = books.id join orders on orders.id = order_items.order_id where orders.order_status_id > 1 group by books.id) AS B) AS A 
      WHERE Row_ID < 2 ORDER BY category_id;")
    @order_item = current_order.order_items.new if current_user
    @order_item = current_order.guest_order_items.new if !current_user
  end
end
