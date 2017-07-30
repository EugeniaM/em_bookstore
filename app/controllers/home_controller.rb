class HomeController < ApplicationController  
  def index
    @last_added_books = Book.last(3)
    @best_sellers = Book.find_by_sql("SELECT * FROM 
      (SELECT *, ROW_NUMBER() OVER (PARTITION BY category_id order by order_counter DESC) AS Row_ID FROM books) AS A
      WHERE Row_ID < 2 ORDER BY category_id")
  end
end
