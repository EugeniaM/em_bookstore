require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to render_template('show')
    end
  end

end
