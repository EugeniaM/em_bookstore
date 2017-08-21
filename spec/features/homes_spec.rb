require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Home" do
  subject { page }
  let(:current_user) { FactoryGirl.create(:user) }
  begin
    order_status = OrderStatus.find(1)
  rescue
    order_status = FactoryGirl.create(:order_status, id: 1)
  end
  let(:current_order) { FactoryGirl.create(:order, order_status: order_status, user: current_user) }
  before(:each) do
    categories = FactoryGirl.create_list(:category, 4)
    @categories = categories
    best_sellers = FactoryGirl.create_list(:book, 4)
    @best_sellers = best_sellers
    last_added_books = FactoryGirl.create_list(:book, 3)
    @last_added_books = last_added_books
    @order_item = current_order.order_items.new
    visit root_path 
  end

  it { should have_selector('h2', text: I18n.t('home.welcome_msg')) }

  it "should have the right links on the layout" do
    visit root_path
    first(:link, I18n.t('header.sign_up')).click
    expect(page).to have_selector('h3', text: I18n.t('auth.sign_up'))
    
    visit root_path
    first(:link, I18n.t('header.log_in')).click
    expect(page).to have_selector('h3', text: I18n.t('auth.log_in'))
    
    visit root_path
    first(:link, "#{@categories[0].name}").click
    expect(page).to have_selector('h1', text: I18n.t('catalog.catalog'))

    visit root_path
    click_link(I18n.t('home.get_started'))
    expect(page).to have_selector('h1', text: I18n.t('catalog.catalog'))

    visit root_path
    first('#eye', visible: false).click
    expect(page).to have_selector('i.fa.fa-long-arrow-left')
  end

  describe "when cart is empty" do
    it { should have_selector('span.shop-icon') }
    it { should_not have_selector('span.shop-icon.full-cart') }
  end

  describe "when click on cart icon inside best_sellers list", js: true do
    it "should add items in order_items" do
      first('.thumb-hover-link.submit', visible: false).click
      expect(page).to have_selector('.full-cart')
    end
  end

  describe "when click on cart icon inside carousel list", js: true do
    it "should add items in order_items" do
      first('.carousel-buy-link').click
      expect(page).to have_selector('.full-cart')
    end
  end

  describe "when click on 'Buy Now' button inside carousel list", js: true do
    it "should add items in order_items" do
      first('.carousel-buy-link').click
      expect(page).to have_selector('.full-cart')
    end
  end

  describe "when click on Cart icon inside header" do
    it "should redirect to cart page" do
      first('.shop-link.pull-right').click
      expect(page).to have_selector('h1.general-title-margin', text: I18n.t('cart_page.cart_title'))
    end
  end
end
