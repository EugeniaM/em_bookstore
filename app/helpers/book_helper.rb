module BookHelper
  def show_reviews
    !!@reviews_list
  end

  def glyph_icon(*names)
    content_tag :i, nil, class: names.map{|name| "glyphicon glyphicon-#{name.to_s.gsub('_','-')}" }
  end

  def score
    @score
  end

  def reviews_count
    @book.reviews.count
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
end