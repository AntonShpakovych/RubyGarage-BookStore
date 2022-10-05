# frozen_string_literal: true

RSpec.describe OrderService do
  let(:order_service) { described_class.new(current_user, cookies) }

  before { order_service.call }

  context 'when current_user present' do
    let!(:current_user) { create(:user) }
    let(:cookies) { {} }

    context 'when order not present for current_user' do
      let(:result) { current_user.orders }

      it 'create order for current_user' do
        expect(result).not_to be_nil
      end
    end

    context 'when order present for current_user' do
      let(:order) { create(:order, user: current_user) }
      let(:result) { current_user.orders.include?(order) }

      it 'return order unprocessed with current_user' do
        expect(result).to be_truthy
      end
    end
  end

  context 'when current_user not present' do
    let(:current_user) { nil }

    context 'when our guess not use cart early' do
      let(:cookies) { {} }
      let(:result) { order_service.cookies[:order_id] }
      let(:expected_result) { Order.first }

      it 'create order and write order_id to cookies' do
        expect(result).to eq(expected_result.id)
      end
    end

    context 'when our guess use cart early' do
      let(:order) { create(:order) }
      let(:cookies) { { order_id: order.id } }

      let(:result) { order_service.call.id }

      it 'return order where order_id == cookies[:order_id]' do
        expect(result).to eq(order.id)
      end
    end
  end
end
