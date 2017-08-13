require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Book page" do
  subject { page }
  let(:book) { FactoryGirl.create(:book, full_description: 'a'*500) }
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    visit book_path(book.id)
  end

  it { should have_selector('h1', text: book.title) }
  it { should have_selector("input[value='1']") }
  it { should have_selector('.read-more', text: I18n.t('book_page.read_more')) }
  it { should have_selector('.no-user-review') }

  # scenario "user clicks 'plus' icon to increment quantity of books" do
    # @qty = 1
    # page.execute_script %($('#increment').click())
    # expect(page).to have_field("#quantity-input", with: 1)
  # end

  scenario "user clicks 'Read More' link to expand full description", js: true do
    page.execute_script %($('.read-more').click())
    expect(page).not_to have_selector('.read-more', text: I18n.t('book_page.read_more'))
  end

  describe "signed in user can see form for review" do
    before do
      visit new_user_session_path
      fill_in I18n.t('auth.email_label'), with: user.email
      fill_in I18n.t('auth.psw_label'), with: user.password
      click_button(I18n.t('auth.log_in'))
      visit book_path(book.id)
    end

    it { should have_selector('.form-group') }

    describe "save review with invalid title and text" do
      before do
        fill_in I18n.t('book_page.title'), with: " "
        fill_in I18n.t('book_page.review'), with: " "
      end

      it "shouldn't save review" do
        count = Review.count
        click_button(I18n.t('book_page.post'))
        expect(Review.count).to eq(count)
      end
    end

    describe "save review with valid title and text" do
      before do
        fill_in I18n.t('book_page.title'), with: "Test review"
        fill_in I18n.t('book_page.review'), with: "This is a test review"
      end

      it "should save review" do
        count = Review.count
        click_button(I18n.t('book_page.post'))
        expect(Review.count).to be > count
      end
    end

    describe "user has already left review, admin hasn't approved it yet" do
      before do
        review = FactoryGirl.create(:review, user: user, book: book)
        visit book_path(book.id)
      end

      it { should have_selector('.success-msg', text: I18n.t('book_page.success_msg')) }
    end

    describe "user has already left review, admin has approved it" do
      before do
        review = FactoryGirl.create(:review, status: "Approved", user: user, book: book)
        visit book_path(book.id)
      end

      it { should have_selector('.stop-reviews', text: I18n.t('book_page.stop_reviews')) }
    end
  end

  describe "user clicks 'Reviews' tab and there are no reviews", js: true do
    before do
      find('#reviews-list-tab').click
    end

    it "should show 'No reviews yet' if book doesn't have reviews" do
      expect(page).to have_selector('.no-reviews-msg', text: I18n.t('book_page.no_reviews'))
    end
  end

  describe "user clicks 'Reviews' tab and there are reviews", js: true do
    before do
      user = FactoryGirl.build(:user)
      review = FactoryGirl.create(:review, status: "Approved", user: user, book: book)
      find('#reviews-list-tab').click
    end

    it "should show 'No reviews yet' if book doesn't have reviews" do
      expect(page).to have_selector('.general-message-wrap')
    end
  end

  describe "button 'Back to results' should redirect to previous page", js: true do
    before do
      visit root_path
      visit book_path(book.id)
      find('.general-back-link').click
    end

    it { should have_selector('h2', text: I18n.t('home.welcome_msg')) }
  end

end
