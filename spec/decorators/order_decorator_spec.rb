# frozen_string_literal: true

RSpec.describe OrderDecorator do
  let!(:coupon) { create(:coupon, discount: 50) }
  let!(:book1) { create(:book, price: 10) }
  let!(:book2) { create(:book, price: 5) }

  let!(:order_item1) { create(:order_item, book: book1, quantity: 2) }
  let!(:order_item2) { create(:order_item, book: book2, quantity: 2) }

  let!(:order_items) { [order_item1, order_item2] }
  let!(:order) { create(:order, coupon: coupon, order_items: order_items).decorate }

  let(:expected_result_subtotal_price) { 30 }
  let(:expected_result_discount) { discount }
  let(:expected_result_total_price) { 15 }

  describe '#subtotal_price' do
    let(:result) { order.subtotal_price }

    it 'give subtotal money for order_items' do
      expect(result).to eq(expected_result_subtotal_price)
    end
  end

  describe '#discount' do
    let(:result) { order.discount }

    context 'when coupon present' do
      let(:discount) { 15 }

      it 'shows how much money you have saved' do
        expect(result).to eq(expected_result_discount)
      end
    end

    context 'when coupon not present' do
      let(:order) { create(:order).decorate }
      let(:discount) { Constants::Shared::CART_EMPTY }

      it 'shows how much money you have saved' do
        expect(result).to eq(expected_result_discount)
      end
    end
  end

  describe '#total_price' do
    let(:result) { order.total_price }

    context 'when order with default delivery' do
      it 'give total money for order' do
        expect(result).to eq(expected_result_total_price)
      end
    end

    context 'when user choose delivery' do
      let!(:order) { create(:order, :delivery, coupon: coupon, order_items: order_items).decorate }
      let(:expected_result) { 15 + order.delivery.price }

      it 'give total money for order include delivery.price' do
        expect(result).to eq(expected_result)
      end
    end
  end
end
