module BookHelper
  def show_reviews
    !!@reviews_list
  end

  def show_reviews_counter
    "#{I18n.t('book_page.reviews')} (#{reviews_count})"
  end

  def glyph_icon(*names)
    content_tag :i, nil, class: names.map{|name| "glyphicon glyphicon-#{name.to_s.gsub('_','-')}" }
  end

  def score
    @score
  end

  def reviews_count
    @book.reviews.select { |review| review.status == "Approved"}.count
  end

  def name_avatar(review)
    review.user[:first_name] ? review.user[:first_name].slice(0, 1) : review.user[:email].slice(0, 1)
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

  def display_name(user)
    return "#{user[:first_name]} #{user[:last_name]}" if user[:first_name] && user[:last_name]
    "DEFAULT"
  end

  def approved(reviews)
    reviews.select { |review| review.status == "Approved"}
  end

  def stop_write_reviews(user)
    user_reviews = @book.reviews.select { |review| review.user_id == user.id }
    user_reviews.size != 0
  end

  def review_approved(user)
    user_reviews = @book.reviews.select { |review| review.user_id == user.id }
    approved_reviews = user_reviews.select { |review| review.status == "Approved" }
    approved_reviews.size != 0
  end
end