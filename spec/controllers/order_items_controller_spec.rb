# frozen_string_literal: true

RSpec.describe OrderItemsController, type: :controller do
  let(:quantity) { OrderItemsService::DEFAULT_QUANTITY_INCREMENT }
  let(:params) { { order_item: { book_id: book_id, quantity: quantity } } }

  describe 'POST #create' do
    let!(:book) { create(:book) }
    let(:book_id) { book.id }

    before { post :create, params: params }

    it 'redirect_to cart_path' do
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'PUT #update' do
    let!(:order) { create(:order, :order_items) }
    let(:book_id) { order.order_items.first.book.id }

    before do
      params[:id] = order.order_items.first.id
      put :update, params: params
    end

    it 'redirect_to cart_path' do
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:order) { create(:order, :order_items) }
    let(:params_destroy) { { id: order.order_items.first.id } }

    before do
      delete :destroy, params: params_destroy
    end

    it 'redirect_to cart_path' do
      expect(response).to redirect_to(cart_path)
    end
  end
end
