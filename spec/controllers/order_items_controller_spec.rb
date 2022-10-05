# frozen_string_literal: true

RSpec.describe OrderItemsController, type: :controller do
  let(:quantity) { OrderItemsService::DEFAULT_QUANTITY_INCREMENT }
  let(:params) { { id: id, order_item: { book_id: book_id, quantity: quantity } } }

  describe 'POST #create' do
    let!(:book) { create(:book) }
    let(:book_id) { book.id }
    let(:id) { nil }
    let(:quantity) { 1 }

    before { post :create, params: params }

    it 'redirect_to cart_path' do
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'PUT #update' do
    let!(:book) { create(:book, quantity: 1) }
    let!(:order_item) { create(:order_item, book: book) }
    let!(:order) { create(:order, order_items: [order_item]) }
    let(:book_id) { book.id }
    let(:id) { order.order_items.first.id }
    let(:quantity) { 1 }

    before do
      put :update, params: params
    end

    context 'when book.quantity more after updated order_item.quantity' do
      let(:quantity) { book.quantity + 10 }

      it 'redirect_to cart_path' do
        expect(response).to redirect_to(cart_path)
      end
    end

    context 'when book.quantity less after updated order_item.quantity' do
      it 'redirect_to cart_path' do
        expect(response).to redirect_to(cart_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:order) { create(:order, :order_items) }
    let(:params) { { id: id } }

    before do
      delete :destroy, params: params
    end

    context 'when correct id' do
      let(:id) { order.order_items.first.id }

      it 'redirect_to cart_path' do
        expect(response).to redirect_to(cart_path)
      end
    end

    context 'when incorrect id' do
      let(:id) { order.order_items.first.id.next }

      it 'redirect_to cart_path' do
        expect(response).to redirect_to(cart_path)
      end
    end
  end
end
