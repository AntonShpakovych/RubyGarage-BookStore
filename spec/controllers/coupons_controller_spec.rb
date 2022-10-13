# frozen_string_literal: true

RSpec.describe CouponsController, type: :controller do
  describe 'PUT #update' do
    let!(:coupon) { create(:coupon) }
    let(:params) { { coupon: { code: code } } }

    context 'when params good' do
      let(:code) { coupon.code }

      before { put :update, params: params }

      it 'redirect_to cart_path' do
        expect(response).to redirect_to(cart_path)
      end
    end

    context 'when params bad' do
      let(:code) { 'somebad' }

      before { put :update, params: params }

      it 'redirect_to cart_path' do
        expect(response).to redirect_to(cart_path)
      end
    end

    context 'when params good but coupon already have order_id' do
      let!(:order) { create(:order) }
      let!(:coupon) { create(:coupon, order: order) }
      let(:code) { coupon.code }

      before { put :update, params: params }

      it 'redirect_to cart_path' do
        expect(response).to redirect_to(cart_path)
      end
    end
  end
end
