def sort_order_regex(sort_by_attributes)
  /#{Book.order(sort_by_attributes)
    .map { |b| Regexp.quote(b.title) }
    .join(".+")}/
end

def filter_regex(category)
  if !category
    /#{Book.all.map { |b| Regexp.quote(b.title) }
    .join(".+")}/
  else
    /#{Book.where(category: category)
      .map { |b| Regexp.quote(b.title) }
      .join(".+")}/
  end
end