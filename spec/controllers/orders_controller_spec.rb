# frozen_string_literal: true

RSpec.describe OrdersController, type: :controller do
  let!(:order) { create(:order, :order_items) }
  let!(:user) { create(:user, orders: [order]) }

  before { controller.stub(:current_user) { user } }

  describe 'GET #index' do
    let(:params) { { status: :in_queue } }

    before { get :index, params: params }

    it 'render page index' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:params) { { id: order.id } }

    before { get :show, params: params }

    it 'render page show' do
      expect(response).to render_template(:show)
    end
  end
end
