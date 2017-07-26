require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe User do
  # let(:user) { FactoryGirl.create(:user) }
  # subject { user }
  before { @user = User.new(email: "test@yopmail.com", password: "Testtest1", password_confirmation: "Testtest1") }

  subject { @user }

  it { should respond_to(:email) }
  it { should be_valid }

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = " " }
    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@ @foo.com user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com
                      foo@bar..com foo.@bar.com foo@.bar.com foo@-bar.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn $%&@foo.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when password format is invalid" do
    it "should be invalid" do
      passwords = %w[a aaaaaaaa Aaaaaaaa 11111111 AAAAAAAA aaaaa111]
      passwords.each do |invalid_password|
        @user.password = invalid_password
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when password format is valid" do
    it "should be valid" do
      passwords = %w[Aaaaaaa1 AAAaaaa11 11AAaaaa]
      passwords.each do |valid_password|
        @user.password = valid_password
        expect(@user).to be_valid
      end
    end
  end
end
