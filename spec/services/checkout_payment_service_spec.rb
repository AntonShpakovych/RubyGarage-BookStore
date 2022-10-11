# frozen_string_literal: true

RSpec.describe CheckoutPaymentService do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }
  let(:convert_params) { ActionController::Parameters.new(params) }
  let(:params) { { payment: { number: number, name: name, date: date, cvv: cvv, order_id: order.id } } }
  let(:set_payment) do
    order.to_delivery!
    order.to_payment!
  end

  let(:payment_service) { described_class.new(user, order, convert_params) }
  let(:result) { order.state }

  before do
    set_payment
    payment_service.call
  end

  context 'when valid' do
    let(:number) { attributes_for(:credit_card)[:number] }
    let(:name) { attributes_for(:credit_card)[:name] }
    let(:date) { attributes_for(:credit_card)[:date] }
    let(:cvv) { attributes_for(:credit_card)[:cvv] }
    let(:expected_result) { 'confirm' }

    it 'change order.state to confirm' do
      expect(result).to eq(expected_result)
    end
  end

  context 'when invalid' do
    let(:number) { '111' }
    let(:name) { attributes_for(:credit_card)[:name] }
    let(:date) { attributes_for(:credit_card)[:date] }
    let(:cvv) { attributes_for(:credit_card)[:cvv] }
    let(:expected_result) { 'payment' }
    let(:result_invalid) { payment_service.call.errors.present? }

    it 'not change order.state' do
      expect(result).to eq(expected_result)
    end

    it 'give form with errors' do
      expect(result_invalid).to be_truthy
    end
  end
end
