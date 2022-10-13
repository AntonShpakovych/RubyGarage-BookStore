# frozen_string_literal: true

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    let(:order) { create(:order) }

    before { get :show }

    it 'render cart_path' do
      expect(response).to render_template(:show)
    end
  end
end
