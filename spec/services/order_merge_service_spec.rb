# frozen_string_literal: true

RSpec.describe OrderMergeService do
  let(:order_merge_service) do
    described_class.new(user: user, guest_order: guest_order, cookies: cookies, user_order: user_order)
  end

  context 'when user and cookies[:order_id] not present' do
    let(:user) { nil }
    let(:cookies) { { order_id: nil } }
    let(:guest_order) { nil }
    let(:user_order) { nil }

    let(:result) { order_merge_service.call.present? }

    it 'nothing do' do
      expect(result).not_to be_present
    end
  end

  context 'when we have user and cookies[:order_id]' do
    let!(:coupon_user) { create(:coupon) }
    let!(:coupon_guest) { create(:coupon) }

    let!(:order_item_user) { create(:order_item) }
    let!(:order_item_guest) { create(:order_item) }

    let(:user_order) { create(:order, user: user, order_items: [order_item_user], coupon: coupon_user) }
    let(:guest_order) { create(:order, order_items: [order_item_guest], coupon: coupon_guest) }

    let(:cookies) { { order_id: guest_order.id } }

    let!(:user) { create(:user) }

    let(:result_find_user_order) { user.orders.find_by(status: Order.statuses.fetch(:unprocessed)) }
    let(:result_order_items) { result_find_user_order.order_items }
    let(:result_coupon) { result_find_user_order.coupon }

    let(:expected_result) { guest_order.order_items }

    before { order_merge_service.call }

    it 'delete user_order and add guest_order to user' do
      expect(result_order_items).to eq(expected_result)
    end

    it 'delete user_order.coupon if he present also set guest_order coupon if he present' do
      expect(result_coupon).to eq(coupon_guest)
    end

    context 'when user_order not empty but guess_order empty' do
      let(:result_guest_order) { Order.find_by(id: guest_order.id) }
      let(:guest_order) { create(:order) }
      let(:expected_result) { [order_item_user] }

      it 'not change user_order' do
        expect(result_order_items).to eq(expected_result)
      end

      it 'delete guest_order' do
        expect(result_guest_order).to be_nil
      end
    end
  end
end
