ActiveAdmin.register Book do
  permit_params :title, :short_description, :full_description, :price, :category_id, author_ids:[],
                book_authors_attributes: [:id, :book_id, :author_id, :_destroy], covers: []

  index do
    selectable_column
    column :id
    column :title
    column :short_description
    column :price
    column :created_at
    column :updated_at
    column :category
    column :author do |book| book.authors.map { |d| d }.join(", ").html_safe end

    actions
  end
  
  show do |book|
    puts "!!!!!!!"
    puts book.covers.empty?
    puts "!!!!!!!"
    attributes_table do
      row :id
      row :title
      row :short_description
      row :full_description
      row :price
      row :created_at
      row :updated_at
      row :category
      row :author do |book|
        book.authors.map { |d| d }.join(", ").html_safe
      end
      row :covers do
        ul do
          book.covers.each do |cover|
            li do
              image_tag(cover.url(:thumb))
            end
          end
        end
      end
    end
  end
 
  form html: { multipart: true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :category
      f.input :title
      f.input :short_description
      f.input :full_description
      f.input :price
      f.has_many :book_authors, allow_destroy: true do |deg|
        deg.input :author
      end
      f.input :covers, as: :file, input_html: { multiple: true }
    end

    f.actions
  end 
end
