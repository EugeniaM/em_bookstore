require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe "Settings page" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    visit new_user_session_path
    fill_in I18n.t('auth.email_label'), with: user.email
    fill_in I18n.t('auth.psw_label'), with: user.password
    click_button(I18n.t('auth.log_in'))
    visit "/users/settings"
  end

  it { should have_selector('h3', I18n.t('settings_page.settings')) }
  it { should have_link(I18n.t('settings_page.address'), href: "#address") }
  it { should have_link(I18n.t('settings_page.privacy'), href: "#privacy") }

  describe "user clicks 'Privacy' tab" do
    it "should display privacy tab" do
      click_link(I18n.t('settings_page.privacy'))
      expect(page).to have_selector('p.in-gold-500.font-18.mb-25', I18n.t('settings_page.email'))
    end
  end

  describe "user clicks 'Address' tab" do
    it "should display address tab" do
      click_link(I18n.t('settings_page.privacy'))
      click_link(I18n.t('settings_page.address'))
      expect(page).to have_selector('h3.general-subtitle.mt-0', I18n.t('settings_page.billing_address'))
      expect(page).to have_selector('h3.general-subtitle.mt-0', I18n.t('settings_page.shipping_address'))
    end
  end

  describe "user fills in billing address form and saves it" do
    describe "user fills in all fields with valid data" do
      it "should save billing address when save button is clicked" do
        click_link(I18n.t('settings_page.address'))
        within('div.billing-address-container') do
          @billing_address = BillingAddress.new
          fill_in I18n.t('settings_page.first_name'), with: "Test"
          fill_in I18n.t('settings_page.last_name'), with: "Test"
          fill_in I18n.t('settings_page.address'), with: "Test, 1"
          fill_in I18n.t('settings_page.city'), with: "Test"
          fill_in I18n.t('settings_page.zip'), with: "123456"
          select "Ukraine", from: "billing_address_country"
          fill_in I18n.t('settings_page.phone'), with: "+1111111111"
          first('input#billing-address-user', visible: false).set(user.id)

          click_button(I18n.t('settings_page.save'))
        end
        user_billing_address = BillingAddress.find_by user_id: user.id
        expect(user_billing_address).not_to be_nil
      end
    end

    describe "user fills in some fields with invalid data" do
      it "should not save billing address when save button is clicked" do
        click_link(I18n.t('settings_page.address'))
        within('div.billing-address-container') do
          @billing_address = BillingAddress.new
          fill_in I18n.t('settings_page.first_name'), with: "qwert123"
          fill_in I18n.t('settings_page.last_name'), with: "Test"
          fill_in I18n.t('settings_page.address'), with: "street\\"
          fill_in I18n.t('settings_page.city'), with: "Test"
          fill_in I18n.t('settings_page.zip'), with: "123qwe"
          select "Ukraine", from: "billing_address_country"
          fill_in I18n.t('settings_page.phone'), with: "111111111"

          click_button(I18n.t('settings_page.save'))
        end

        user_billing_address = BillingAddress.find_by user_id: user.id
        expect(user_billing_address).to be_nil
      end
    end
  end

  describe "user fills in shipping address form and saves it" do
    describe "user fills in all fields with valid data" do
      it "should save shipping address when save button is clicked" do
        click_link(I18n.t('settings_page.address'))
        within('div.shipping-address-container') do
          @shipping_address = ShippingAddress.new
          fill_in I18n.t('settings_page.first_name'), with: "Test"
          fill_in I18n.t('settings_page.last_name'), with: "Test"
          fill_in I18n.t('settings_page.address'), with: "Test, 1"
          fill_in I18n.t('settings_page.city'), with: "Test"
          fill_in I18n.t('settings_page.zip'), with: "123456"
          select "Ukraine", from: "shipping_address_country"
          fill_in I18n.t('settings_page.phone'), with: "+1111111111"

          click_button(I18n.t('settings_page.save'))
        end

        user_shipping_address = ShippingAddress.find_by user_id: user.id
        expect(user_shipping_address).not_to be_nil
      end
    end

    describe "user fills in some fields with invalid data" do
      it "should not save shipping address when save button is clicked" do
        click_link(I18n.t('settings_page.address'))
        within('div.shipping-address-container') do
          @shipping_address = ShippingAddress.new
          fill_in I18n.t('settings_page.first_name'), with: "qwert123"
          fill_in I18n.t('settings_page.last_name'), with: "Test"
          fill_in I18n.t('settings_page.address'), with: "street\\"
          fill_in I18n.t('settings_page.city'), with: "Test"
          fill_in I18n.t('settings_page.zip'), with: "123qwe"
          select "Ukraine", from: "shipping_address_country"
          fill_in I18n.t('settings_page.phone'), with: "111111111"

          click_button(I18n.t('settings_page.save'))
        end

        user_shipping_address = ShippingAddress.find_by user_id: user.id
        expect(user_shipping_address).to be_nil
      end
    end
  end

  describe "user changes email in privacy section" do
    it "should change user's email when save button is clicked" do
      within('div.email-form') do
        fill_in 'email', with: "aaaaaa@aaa.com"
        click_button(I18n.t('settings_page.save'))
      end

      new_user = User.find_by email: "aaaaaa@aaa.com"
      expect(new_user).not_to be_nil
    end
  end

  describe "user changes password in privacy section" do
    it "should change user's password when save button is clicked" do
      within('div.password-form') do
        fill_in I18n.t('settings_page.old_psw'), with: user.password
        fill_in I18n.t('settings_page.new_psw'), with: "Testtest1"
        fill_in I18n.t('settings_page.confirm_psw'), with: "Testtest1"
        click_button(I18n.t('settings_page.save'))
      end
      visit new_user_session_path
      fill_in I18n.t('auth.email_label'), with: user.email
      fill_in I18n.t('auth.psw_label'), with: "Testtest1"
      click_button(I18n.t('auth.log_in'))
      visit "/users/settings"

      expect(page).to have_selector('h3', I18n.t('settings_page.settings'))
    end
  end

  describe "user reomves account in privacy section" do
    it "should remove user account when 'Please Remove My Account' button is clicked" do
      find(:css, ".checkbox-icon").click
      first('#delete-btn').click
      removed_user = User.find_by id: user.id
      expect(removed_user).to be_nil
      expect(page).to have_selector('h2', text: I18n.t('home.welcome_msg'))
    end
  end

end
