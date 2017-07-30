require 'rails_helper'
require_relative '../spec_helper'

RSpec.describe HomeController do
  let(:book) { FactoryGirl.create(:book) }

  describe '#index' do
    before do
      allow(Book).to receive(:last).and_return([book])
      allow(Book).to receive(:find_by_sql).and_return([book])
    end

    it 'expect to render :index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'expect to assigns @last_added_books' do
      get :index
      expect(assigns(:last_added_books)).not_to be_nil
    end

    it 'expect to assigns @best_sellers' do
      get :index
      expect(assigns(:best_sellers)).not_to be_nil
    end

    it 'expect to receive :last' do
      expect(Book).to receive(:last)
      get :index
    end

    it 'expect to receive :find_by_sql' do
      expect(Book).to receive(:find_by_sql)
      get :index
    end
  end
end