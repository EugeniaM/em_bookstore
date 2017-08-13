require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Home" do
  subject { page }
  before(:each) do
    categories = FactoryGirl.create_list(:category, 4)
    @categories = categories
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
  end
end
