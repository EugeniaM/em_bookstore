require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Home" do
  subject { page }
  before { visit root_path }

  it { should have_selector('h2', text: I18n.t('home.welcome_msg')) }

  it "should have the right links on the layout" do
    first(:link, I18n.t('header.sign_up')).click
    expect(page).to have_selector('h3', text: I18n.t('auth.sign_up'))
    first(:link, I18n.t('header.log_in')).click
    expect(page).to have_selector('h3', text: I18n.t('auth.log_in'))
  end
end
