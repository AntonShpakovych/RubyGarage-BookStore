# frozen_string_literal: true

RSpec.describe OrderDecorator do
  let!(:order) { create(:order, :order_items).decorate }

  describe '#subtotal' do
    let(:result) { order.subtotal }
    let(:expected_result) { order.order_items.sum { |item| item.quantity * item.book.price } }

    it 'give subtotal money for order_items' do
      expect(result).to eq(expected_result)
    end
  end

  describe 'functionality with coupon' do
    let(:max_discount) { Coupon::MAX_DISCOUNT }
    let(:subtotal) { order.order_items.sum { |item| item.quantity * item.book.price } }
    let(:discount) { subtotal * order.coupon.discount / max_discount }

    before { create(:coupon, order_id: order.id) }

    describe '#discount' do
      let(:result) { order.discount }
      let(:expected_result) { discount }

      it 'shows how much money you have saved' do
        expect(result).to eq(expected_result)
      end

      context 'when order without coupon' do
        let(:default_discount) { Coupon::MIN_DISCOUNT }

        before { order.coupon = nil }

        it 'give default discount' do
          expect(result).to eq(default_discount)
        end
      end
    end

    describe '#order_total' do
      let(:result) { order.order_total }
      let(:expected_result) { subtotal - discount }

      it 'give total money for order' do
        expect(result).to eq(expected_result)
      end
    end
  end
end
