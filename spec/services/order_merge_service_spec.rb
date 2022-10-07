# frozen_string_literal: true

RSpec.describe OrderMergeService do
  let(:order_merge_service) do
    described_class.new(user: user, guess_order: guess_order, cookies: cookies, user_order: user_order)
  end

  context 'when user and cookies[:order_id] not present' do
    let(:user) { nil }
    let(:cookies) { { order_id: nil } }
    let(:guess_order) { nil }
    let(:user_order) { nil }

    let(:result) { order_merge_service.call.present? }

    it 'nothing do' do
      expect(result).not_to be_present
    end
  end

  context 'when we have user and cookies[:order_id]' do
    let!(:coupon_user) { create(:coupon) }
    let!(:coupon_guess) { create(:coupon) }

    let!(:order_item_user) { create(:order_item) }
    let!(:order_item_guess) { create(:order_item) }

    let(:user_order) { create(:order, user: user, order_items: [order_item_user], coupon: coupon_user) }
    let(:guess_order) { create(:order, order_items: [order_item_guess], coupon: coupon_guess) }

    let(:cookies) { { order_id: guess_order.id } }

    let!(:user) { create(:user) }

    let(:result_find_user_order) { user.orders.find_by(status: Order.statuses.fetch(:unprocessed)) }
    let(:result_order_items) { result_find_user_order.order_items }
    let(:result_coupon) { result_find_user_order.coupon }

    let(:expected_result) { guess_order.order_items }

    before { order_merge_service.call }

    it 'delete user_order and add guess_order to user' do
      expect(result_order_items).to eq(expected_result)
    end

    it 'delete user_order.coupon if he present also set guess_order coupon if he present' do
      expect(result_coupon).to eq(coupon_guess)
    end

    context 'when user_order not empty but guess_order empty' do
      let(:result_guess_order) { Order.find_by(id: guess_order.id) }
      let(:guess_order) { create(:order) }
      let(:expected_result) { [order_item_user] }

      it 'not change user_order' do
        expect(result_order_items).to eq(expected_result)
      end

      it 'delete guess_order' do
        expect(result_guess_order).to be_nil
      end
    end
  end
end
