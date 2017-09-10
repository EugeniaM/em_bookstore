module BooksHelper
  def categories
    Category.all
  end

  def books_count
    Book.all.count
  end

  def define_filter_href category
    arr = []
    if !category
      params = {}.merge(request.query_parameters)
      params.delete("category")
    else
      params = request.query_parameters.merge({category: category})
    end
    params.each do |key, value|
      arr.push("#{key}=#{value}")
    end
    "/books?#{arr.join('&')}"
  end

  def selected_category? category
    if category == 'all'
      !params[:category].present?
    else
      category.to_s == params[:category].to_s
    end
  end

  def selected_category
    selected = Category.find(params[:category]) if params[:category].present?
    return "#{selected.name} (#{selected.books.count})" if selected
    "#{I18n.t('catalog.all')} (#{Book.all.count})"
  end

  def selected_sort
    selected_sort = sort_config.select do |sort|
      sort[:sort_field].to_s == params[:custom_sort].to_s
    end
    "#{selected_sort[0][:sort_title]}" if selected_sort
  end
  
  def define_sort_href params
    arr = []
    params = request.query_parameters.merge({custom_sort: params})
    params.each do |key, value|
      arr.push("#{key}=#{value}")
    end
    "/books?#{arr.join('&')}"
  end

  def sort_config
    [
      {
        sort_title: I18n.t('catalog.newest_first'),
        sort_field: "created_at DESC",
        direction: "DESC"
      },
      {
        sort_title: I18n.t('catalog.popular_first'),
        sort_field: "order_counter DESC",
        direction: "DESC"
      },
      {
        sort_title: I18n.t('catalog.price_low_hight'),
        sort_field: "price ASC",
        direction: "ASC"
      },
      {
        sort_title: I18n.t('catalog.price_high_low'),
        sort_field: "price DESC",
        direction: "DESC"
      },
      {
        sort_title: I18n.t('catalog.title_a_z'),
        sort_field: "title ASC",
        direction: "ASC"
      },
      {
        sort_title: I18n.t('catalog.title_z_a'),
        sort_field: "title DESC",
        direction: "DESC"
      }
    ]
  end

  
end
