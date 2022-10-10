# frozen_string_literal: true

RSpec.describe 'Checkout page', type: :feature do
  let!(:order_item) { create(:order_item) }
  let!(:order) { create(:order, order_items: [order_item]) }
  let!(:user) { create(:user, orders: [order]) }
  let(:result) { page }

  before do
    visit new_user_session_path
    fill_in t('devise.placeholder.email'), with: user.email
    fill_in t('devise.placeholder.password'), with: user.password
    click_button t('devise.default.log_in')
  end

  describe 'Address' do
    context 'when not use_billing' do
      before do
        visit checkout_path
        within('#billing') do
          fill_in 'address[billing][first_name]', with: first_name
          fill_in 'address[billing][last_name]', with: last_name
          fill_in 'address[billing][address]', with: address
          fill_in 'address[billing][city]', with: city
          fill_in 'address[billing][zip]', with: zip
          select country, from: 'address[billing][country]'
          fill_in 'address[billing][phone]', with: phone
        end

        within('#shipping') do
          fill_in 'address[shipping][first_name]', with: first_name
          fill_in 'address[shipping][last_name]', with: last_name
          fill_in 'address[shipping][address]', with: address
          fill_in 'address[shipping][city]', with: city
          fill_in 'address[shipping][zip]', with: zip
          select country, from: 'address[shipping][country]'
          fill_in 'address[shipping][phone]', with: phone
        end
        click_button(t('checkouts.partials.address.button_submit'))
      end

      context 'when data valid' do
        let(:first_name) { attributes_for(:address)[:first_name] }
        let(:last_name) { attributes_for(:address)[:last_name] }
        let(:address) { attributes_for(:address)[:address] }
        let(:city) { attributes_for(:address)[:city] }
        let(:zip) { attributes_for(:address)[:zip] }
        let(:country) { 'Ukraine' }
        let(:phone) { attributes_for(:address)[:phone] }

        let(:result_billing) { user.billing_address.first_name }
        let(:result_shipping) { user.shipping_address.first_name }

        it 'render next state shipping' do
          expect(result).to have_text(t('checkouts.partials.shipping.title'))
        end

        it 'also save addresses to use' do
          expect(result_billing).to eq(first_name)
          expect(result_shipping).to eq(first_name)
        end
      end

      context 'when data invalid' do
        let(:first_name) { 'Someinvalid1' }
        let(:last_name) { attributes_for(:address)[:last_name] }
        let(:address) { attributes_for(:address)[:address] }
        let(:city) { attributes_for(:address)[:city] }
        let(:zip) { attributes_for(:address)[:zip] }
        let(:country) { 'Ukraine' }
        let(:phone) { attributes_for(:address)[:phone] }

        let(:result_billing) { user.billing_address }
        let(:result_shipping) { user.shipping_address }
        let(:expected_result) { t('address.validation.first_name') }

        it 'render address state with errors' do
          expect(result).to have_text(expected_result)
        end

        it 'dont create addresses for user' do
          expect(result_billing).to be_nil
          expect(result_shipping).to be_nil
        end
      end
    end

    context 'when use_billing' do
      let(:first_name) { attributes_for(:address)[:first_name] }
      let(:last_name) { attributes_for(:address)[:last_name] }
      let(:address) { attributes_for(:address)[:address] }
      let(:city) { attributes_for(:address)[:city] }
      let(:zip) { attributes_for(:address)[:zip] }
      let(:country) { 'Ukraine' }
      let(:phone) { attributes_for(:address)[:phone] }

      let(:result_shipping) { user.shipping_address.first_name }
      let(:expected_result) { user.billing_address.first_name }

      before do
        visit checkout_path
        within('#billing') do
          fill_in 'address[billing][first_name]', with: first_name
          fill_in 'address[billing][last_name]', with: last_name
          fill_in 'address[billing][address]', with: address
          fill_in 'address[billing][city]', with: city
          fill_in 'address[billing][zip]', with: zip
          select country, from: 'address[billing][country]'
          fill_in 'address[billing][phone]', with: phone
        end

        within('#shipping') do
          result.find(class: 'checkbox-input', visible: false).check
        end
        result.find(id: 'address_use_billing', visible: false).set(true)

        click_button(t('checkouts.partials.address.button_submit'))
      end

      it 'create shipping address from billing' do
        expect(result_shipping).to eq(expected_result)
      end
    end
  end
end
