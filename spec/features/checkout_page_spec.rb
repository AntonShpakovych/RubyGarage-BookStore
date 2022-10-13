# frozen_string_literal: true

RSpec.describe 'Checkout page', type: :feature do
  let!(:order) { create(:order, order_items: [order_item]) }
  let!(:order_item) { create(:order_item) }
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

        it 'render next state delivery' do
          expect(result).to have_text(t('checkouts.partials.delivery.shipping_method_title'))
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

  describe 'Delivery' do
    let!(:delivery) { create(:delivery) }
    let(:billing_address) { create(:address, :billing_address, user: user) }
    let(:shipping_address) { create(:address, :shipping_address, user: user) }

    let(:expected_result_delyvery_show) { delivery.name }

    before do
      delivery
      order.to_delivery!
      visit checkout_path
    end

    it 'user can see all available delivery' do
      expect(result).to have_text(expected_result_delyvery_show)
    end

    context 'when user want choose delivery' do
      let(:result_delivery) { Order.last.delivery }
      let(:expected_result) { delivery }

      before do
        result.all('input[name="delivery_id"]').first.click
        click_button(t('checkouts.partials.delivery.button_submit'))
      end

      it 'set delivery choosed to order.delivery' do
        expect(result_delivery).to eq(expected_result)
      end
    end
  end

  describe 'Payment' do
    let(:delivery) { create(:delivery, orders: [order]) }
    let(:billing) { create(:address, :billing_address, user: user) }
    let(:shipping) { create(:address, :shipping_address, user: user) }
    let(:card_name) { card_name }
    let(:card_number) { card_number }
    let(:card_date) { card_date }
    let(:card_cvv) { card_cvv }
    let(:set_payment) do
      order.to_delivery!
      order.to_payment!
    end

    before do
      delivery
      billing
      shipping
      set_payment
      visit checkout_path
      fill_in 'payment[number]', with: card_number
      fill_in 'payment[name]', with: card_name
      fill_in 'payment[date]', with: card_date
      fill_in 'payment[cvv]', with: card_cvv
      click_button(t('checkouts.partials.payment.button_submit'))
    end

    context 'when valid' do
      let(:card_name) { attributes_for(:credit_card)[:name] }
      let(:card_number) { attributes_for(:credit_card)[:number] }
      let(:card_date) { attributes_for(:credit_card)[:date] }
      let(:card_cvv) { attributes_for(:credit_card)[:cvv] }
      let(:result_state) { Order.last.state }
      let(:expected_result) { 'confirm' }

      it 'change order.state to confirm' do
        expect(result_state).to eq(expected_result)
      end
    end

    context 'when invalid' do
      let(:card_name) { 'bad1133!' }
      let(:card_number) { attributes_for(:credit_card)[:number] }
      let(:card_date) { attributes_for(:credit_card)[:date] }
      let(:card_cvv) { attributes_for(:credit_card)[:cvv] }
      let(:result_state) { Order.last.state }
      let(:expected_result) { 'payment' }

      it 'not change order.state to confirm' do
        expect(result_state).to eq(expected_result)
      end

      it 'show errors about bad input' do
        expect(result).to have_text(t('checkouts.partials.payment.errors.card_name'))
      end
    end
  end

  describe 'Confirmation' do
    let(:set_confirmation) do
      order.to_delivery!
      order.to_payment!
      order.to_confirm!
    end
    let(:delivery) { create(:delivery, orders: [order]) }
    let(:card) { create(:credit_card, order: order) }
    let(:billing) { create(:address, :billing_address, user: user) }
    let(:shipping) { create(:address, :shipping_address, user: user) }

    let(:expected_result_billing) { billing.first_name }
    let(:expected_result_shipping) { shipping.first_name }

    let(:expected_result_delivery) { delivery.name }
    let(:masked_number) { card.number[-4..] }
    let(:expected_result) { t('checkouts.partials.confirm.payment_info.masked_card', last_number: masked_number) }

    let(:expected_result_book) { order.order_items.sample.book.name }

    before do
      delivery
      card
      billing
      shipping
      set_confirmation
      visit checkout_path
    end

    it 'user can see info about shipping and billing addresses' do
      expect(result).to have_text(billing.first_name)
      expect(result).to have_text(shipping.first_name)
    end

    it 'user can see info about delivery' do
      expect(result).to have_text(expected_result_delivery)
    end

    it 'user can see info about credit_card' do
      expect(result).to have_text(expected_result)
    end

    it 'user can see info about book' do
      expect(result).to have_text(expected_result_book)
    end

    context 'when user want change some data' do
      let(:link_to_address) { result.all('a', class: 'general-edit')[0] }
      let(:link_to_delivery) { result.all('a', class: 'general-edit')[2] }
      let(:link_to_payment) { result.all('a', class: 'general-edit')[3] }

      context 'when user want change some address' do
        let(:expected_result) { t('checkouts.partials.address.title') }

        before { link_to_address.click }

        it 'go back to address' do
          expect(result).to have_text(expected_result)
        end
      end

      context 'when user want change delivery' do
        let(:expected_result) { t('checkouts.partials.delivery.desktop.title') }

        before { link_to_delivery.click }

        it 'go back to delivery' do
          expect(result).to have_text(expected_result)
        end
      end

      context 'when user want change payment' do
        let(:expected_result) { t('checkouts.partials.payment.title') }

        before { link_to_payment.click }

        it 'go back to payment' do
          expect(result).to have_text(expected_result)
        end
      end
    end
  end

  describe 'Complete' do
    let(:set_complete) do
      order.to_delivery!
      order.to_payment!
      order.to_confirm!
      order.to_complete!
    end
    let(:delivery) { create(:delivery, orders: [order]) }
    let(:card) { create(:credit_card, order: order) }
    let(:billing) { create(:address, :billing_address, user: user) }
    let(:shipping) { create(:address, :shipping_address, user: user) }

    let(:expected_result_number) { order.number }
    let(:expected_result_message) { t('checkouts.partials.complete.title') }

    before do
      delivery
      card
      billing
      shipping
      set_complete
      visit checkout_path
    end

    it 'user can see order number' do
      expect(result).to have_text(expected_result_number)
    end

    it 'user can see message' do
      expect(result).to have_text(expected_result_message)
    end

    context 'when user click on Go to Store' do
      before do
        result.find('a', class: 'btn btn-default mb-20').click
      end

      it 'redirect_to books_path' do
        expect(result.current_path).to eq(books_path)
      end
    end
  end
end
