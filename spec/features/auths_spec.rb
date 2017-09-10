require 'rails_helper'
require_relative '../spec_helper'
require_relative '../auth_helper'

RSpec.feature "Authentication and authorization" do
  subject { page }
  describe "facebook authentication and authorization" do
    stub_omniauth

    scenario "user sign up using facebook" do
      visit new_user_registration_path
      expect(page).to have_link('', href: user_facebook_omniauth_authorize_path)
      click_link('', href: user_facebook_omniauth_authorize_path)
      expect(page).to have_selector('h2', text: I18n.t('home.welcome_msg'))
    end

    scenario "user sign in using facebook" do
      visit new_user_session_path
      expect(page).to have_link('', href: user_facebook_omniauth_authorize_path)
      click_link('', href: user_facebook_omniauth_authorize_path)
      expect(page).to have_selector('h2', text: I18n.t('home.welcome_msg'))
    end
  end

  describe "email and password sign up" do
    before { visit new_user_registration_path }
    let(:button) { I18n.t('auth.sign_up') }

    describe "with invalid information" do
      it "should not create a user" do
        click_button(button)
        expect(page).to have_content(I18n.t('auth.sign_up'))
      end
    end

    describe "with valid information" do
      before do
        fill_in I18n.t('auth.email_label'), with: "test@yopmail.com"
        fill_in I18n.t('auth.psw_label'), with: "Testtest1"
        fill_in I18n.t('auth.psw_confirm_label'), with: "Testtest1"
      end

      it "should create a user" do
        click_button(button)
        expect(page).not_to have_content(I18n.t('auth.sign_up'))
      end
    end
  end

  describe "email and password log in" do
    before { visit new_user_session_path }
    let(:button) { I18n.t('auth.log_in') }

    describe "with invalid information" do
      before { click_button(button)}

      it { should have_content(I18n.t('auth.log_in')) }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in I18n.t('auth.email_label'), with: user.email
        fill_in I18n.t('auth.psw_label'), with: user.password
        click_button(button)
      end

      it { should have_link(I18n.t('header.log_out'), href: destroy_user_session_path) }
      it { should_not have_link(I18n.t('header.log_in'), href: new_user_session_path) }
      it { should_not have_link(I18n.t('header.sign_up'), href: new_user_registration_path) }
    end
  end
  
end
