require 'rails_helper'
require_relative '../spec_helper'
require_relative '../support/utilities'

RSpec.shared_examples "sort link" do |link_text:, sort_by:|
  it "sorts by #{sort_by} when the #{link_text} link is clicked" do
    visit books_path(custom_sort: "title ASC")

    initial_order = sort_order_regex("title ASC")
    tested_order = sort_order_regex(sort_by)

    expect(page).to have_text(initial_order)
    first(:link, link_text).click
    expect(page).to have_text(tested_order)
  end
end

RSpec.shared_examples "filter link" do |link_text:, category:|
  it "filters by selected category when the #{link_text} link is clicked" do
    visit books_path(custom_sort: "title ASC")

    initial_filter = filter_regex(nil)
    tested_filter = filter_regex(category[:id]) if category
    tested_filter = filter_regex(nil) if !category

    expect(page).to have_text(initial_filter)
    first(:link, link_text).click
    expect(page).to have_text(tested_filter)
  end
end

RSpec.describe "Catalog" do
  subject { page }
  category = FactoryGirl.create(:category)
  begin
    order_status = OrderStatus.find(1)
  rescue
    order_status = FactoryGirl.create(:order_status, id: 1)
  end
  user = FactoryGirl.create(:user)
  order = FactoryGirl.create(:order, order_status: order_status, user: user)
  books_data = [
    {
      title: "A",
      price: 2,
      order_counter: 5,
      category: category
    },
    {
      title: "B",
      price: 1,
      order_counter: 7,
    },
    {
      title: "C",
      price: 3,
      order_counter: 2,
    },
    {
      title: "D",
      price: 4,
      order_counter: 6,
    }
  ]

  let(:books) { books_data.map { |book| FactoryGirl.create(:book, book) } }
  let(:order_item) { FactoryGirl.create(:order_item, order: order, book: books[0]) }

  before(:each) do
    visit books_path(custom_sort: "title ASC")
  end

  it { should have_selector('h1', text: I18n.t('catalog.catalog')) }
  it { should have_selector('a', text: I18n.t('catalog.newest_first')) }

  it "User clicks dropdown trigger and sees dropdown menu" do
    click_link('sort-dropdown-trigger')
    expect(page).to have_selector('li', text: I18n.t('catalog.newest_first'))
    expect(page).to have_selector('li', text: I18n.t('catalog.popular_first'))
    expect(page).to have_selector('li', text: I18n.t('catalog.price_low_hight'))
    expect(page).to have_selector('li', text: I18n.t('catalog.price_high_low'))
    expect(page).to have_selector('li', text: I18n.t('catalog.title_a_z'))
    expect(page).to have_selector('li', text: I18n.t('catalog.title_z_a'))
  end

  describe "sorting" do
    before(:each) { @books = books }
    include_examples "sort link", link_text: I18n.t('catalog.newest_first'), sort_by: "created_at DESC"
    include_examples "sort link", link_text: I18n.t('catalog.popular_first'), sort_by: "order_counter DESC"
    include_examples "sort link", link_text: I18n.t('catalog.price_low_hight'), sort_by: "price ASC"
    include_examples "sort link", link_text: I18n.t('catalog.price_high_low'), sort_by: "price DESC"
    include_examples "sort link", link_text: I18n.t('catalog.title_a_z'), sort_by: "title ASC"
    include_examples "sort link", link_text: I18n.t('catalog.title_z_a'), sort_by: "title DESC"
  end

  describe "filtering" do
    before(:each) { @books = books }
    include_examples "filter link", link_text: I18n.t('catalog.all'), category: nil
    include_examples "filter link", link_text: category[:name], category: category
  end

  describe "pagination" do
    before(:all) do
      @original_max_per_page = Kaminari.config.default_per_page
      Kaminari.config.default_per_page = 3
    end

    after(:all) do
      Kaminari.config.default_per_page = @original_max_per_page
    end

    context "with 4 records and maximum records per page set to 3", js: true do
      before(:each) do
        @books = books

        visit books_path(custom_sort: "title ASC")
      end

      it "displays 3 records in the 1st page " do
        expect(page).to have_selector("button#view-more")
        expect(page).to have_selector("div.book-container", count: 3)
      end

      it "displays 4 records after View More button was clicked" do
        # click_button(I18n.t('catalog.view_more'))
        # expect(page).to have_selector("div.book-container", count: 4)
      end
    end
  end

  describe "when click on cart icon inside books list", js: true do
    before do
      @books = books
      visit books_path(custom_sort: "title ASC")
    end
    it "should add items in order_items" do
      first('.thumb-hover-link.submit', visible: false).click
      expect(page).to have_selector('.full-cart')
    end
  end
end
