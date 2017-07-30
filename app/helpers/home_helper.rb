module HomeHelper
  def limit_description(description)
    "#{description[0, 180]}..."
  end

  def authors(authors)
    authors.map { |d| d }.join(", ").html_safe
  end
end
