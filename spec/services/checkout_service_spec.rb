# frozen_string_literal: true

RSpec.describe CheckoutService do
  describe 'Address' do
    let!(:user) { create(:user) }
    let!(:order) { create(:order, user: user) }
    let(:convert_params) { ActionController::Parameters.new(params) }
    let(:params) do
      { address: { billing: {
                     first_name: attributes_for(:address)[:first_name],
                     last_name: attributes_for(:address)[:last_name],
                     address: attributes_for(:address)[:address],
                     city: attributes_for(:address)[:city],
                     zip: attributes_for(:address)[:zip],
                     country: attributes_for(:address)[:country],
                     phone: attributes_for(:address)[:phone],
                     type: BillingAddress.name
                   },
                   shipping: {
                     first_name: attributes_for(:address)[:first_name],
                     last_name: attributes_for(:address)[:last_name],
                     address: attributes_for(:address)[:address],
                     city: attributes_for(:address)[:city],
                     zip: attributes_for(:address)[:zip],
                     country: attributes_for(:address)[:country],
                     phone: attributes_for(:address)[:phone],
                     type: ShippingAddress.name
                   } } }
    end

    let(:checkout_service) { described_class.new(user, order, convert_params) }
    let(:result) { checkout_service.call }
    let(:expected_result_hash) { Hash }
    let(:expected_result_form) { AddressForm }

    it 'return hash with billing_form and shipping_form' do
      expect(result).to be_a(expected_result_hash)
      expect(result[:billing]).to be_a(expected_result_form)
      expect(result[:shipping]).to be_a(expected_result_form)
    end

    context 'when addresses be valid' do
      before { result }

      let(:order_state) { order.state }
      let(:expected_result_state) { 'delivery' }

      it 'also change order.state if addresses be valid' do
        expect(order_state).to eq(expected_result_state)
      end
    end
  end
end
