# frozen_string_literal: true

RSpec.describe CheckoutAddressService do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }
  let(:convert_params) { ActionController::Parameters.new(params) }
  let(:params) do
    { address: { billing: {
                   first_name: first_name,
                   last_name: last_name,
                   address: address,
                   city: city,
                   zip: zip,
                   country: country,
                   phone: phone,
                   type: BillingAddress.name
                 },
                 shipping: {
                   first_name: first_name_shipping,
                   last_name: last_name_shipping,
                   address: address_shipping,
                   city: city_shipping,
                   zip: zip_shipping,
                   country: country_shipping,
                   phone: phone_shipping,
                   type: ShippingAddress.name
                 }, use_billing: use_billing } }
  end
  let(:checkout_address_service) { described_class.new(user, order, convert_params) }
  let(:result_billing) { user.billing_address }
  let(:result_shipping) { user.shipping_address }

  before { checkout_address_service.call }

  context 'when all data valid' do
    let(:use_billing) { false }
    let(:first_name) { attributes_for(:address)[:first_name] }
    let(:last_name) { attributes_for(:address)[:last_name] }
    let(:address) { attributes_for(:address)[:address] }
    let(:city) { attributes_for(:address)[:city] }
    let(:zip) { attributes_for(:address)[:zip] }
    let(:country) { attributes_for(:address)[:country] }
    let(:phone) { attributes_for(:address)[:phone] }

    let(:first_name_shipping) { attributes_for(:address)[:first_name] }
    let(:last_name_shipping) { attributes_for(:address)[:last_name] }
    let(:address_shipping) { attributes_for(:address)[:address] }
    let(:city_shipping) { attributes_for(:address)[:city] }
    let(:zip_shipping) { attributes_for(:address)[:zip] }
    let(:country_shipping) { attributes_for(:address)[:country] }
    let(:phone_shipping) { attributes_for(:address)[:phone] }

    let(:result_billing_first_name) { result_billing.first_name }
    let(:expected_billing) { params[:address][:billing][:first_name] }
    let(:result_shipping_first_name) { result_shipping.first_name }
    let(:expected_shipping) { params[:address][:shipping][:first_name] }

    it 'create addresses for user' do
      expect(result_billing).to be_present
      expect(result_shipping).to be_present
    end

    it 'also save data from form in user choosed address' do
      expect(result_billing_first_name).to eq(expected_billing)
      expect(result_shipping_first_name).to eq(expected_shipping)
    end

    it 'change order.state to shipping' do
      expect(order.state).to eq('shipping')
    end
  end

  context 'when some data invalid' do
    let(:use_billing) { false }
    let(:first_name) { 'Invalid1' }
    let(:last_name) { attributes_for(:address)[:last_name] }
    let(:address) { attributes_for(:address)[:address] }
    let(:city) { attributes_for(:address)[:city] }
    let(:zip) { attributes_for(:address)[:zip] }
    let(:country) { attributes_for(:address)[:country] }
    let(:phone) { attributes_for(:address)[:phone] }

    let(:first_name_shipping) { 'Invalid1' }
    let(:last_name_shipping) { attributes_for(:address)[:last_name] }
    let(:address_shipping) { attributes_for(:address)[:address] }
    let(:city_shipping) { attributes_for(:address)[:city] }
    let(:zip_shipping) { attributes_for(:address)[:zip] }
    let(:country_shipping) { attributes_for(:address)[:country] }
    let(:phone_shipping) { attributes_for(:address)[:phone] }

    let(:result_state) { order.state }
    let(:expected_result_state) { 'address' }

    it 'not create addresses for user' do
      expect(result_billing).to be_nil
      expect(result_shipping).to be_nil
    end

    it 'not change order.state' do
      expect(result_state).to eq(expected_result_state)
    end
  end

  context 'when user already have addresses, he can update him' do
    let(:use_billing) { false }
    let(:first_name) { 'Newname' }
    let(:last_name) { attributes_for(:address)[:last_name] }
    let(:address) { attributes_for(:address)[:address] }
    let(:city) { attributes_for(:address)[:city] }
    let(:zip) { attributes_for(:address)[:zip] }
    let(:country) { attributes_for(:address)[:country] }
    let(:phone) { attributes_for(:address)[:phone] }

    let(:first_name_shipping) { 'Newname' }
    let(:last_name_shipping) { attributes_for(:address)[:last_name] }
    let(:address_shipping) { attributes_for(:address)[:address] }
    let(:city_shipping) { attributes_for(:address)[:city] }
    let(:zip_shipping) { attributes_for(:address)[:zip] }
    let(:country_shipping) { attributes_for(:address)[:country] }
    let(:phone_shipping) { attributes_for(:address)[:phone] }

    let(:address_billing_create) { create(:address, :billing_address, first_name: first_name, user: user) }
    let(:result_billing_first_name) { result_billing.first_name }
    let(:expected_billing_first_name) { first_name }

    before do
      address_billing_create
    end

    it 'update address' do
      expect(result_billing_first_name).to eq(expected_billing_first_name)
    end
  end

  context 'when use_billing' do
    let(:use_billing) { 'true' }
    let(:first_name) { 'Newname' }
    let(:last_name) { attributes_for(:address)[:last_name] }
    let(:address) { attributes_for(:address)[:address] }
    let(:city) { attributes_for(:address)[:city] }
    let(:zip) { attributes_for(:address)[:zip] }
    let(:country) { attributes_for(:address)[:country] }
    let(:phone) { attributes_for(:address)[:phone] }

    let(:first_name_shipping) { nil }
    let(:last_name_shipping) { nil }
    let(:address_shipping) { nil }
    let(:city_shipping) { nil }
    let(:zip_shipping) { nil }
    let(:country_shipping) { nil }
    let(:phone_shipping) { nil }

    let(:result) { user.billing_address.first_name }
    let(:expected_result) { user.shipping_address.first_name }

    it 'create shipping_address for user with billing_address' do
      expect(result).to eq(expected_result)
    end
  end
end
