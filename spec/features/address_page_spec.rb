# frozen_string_literal: true

RSpec.describe 'Address page', type: :feature do
  let!(:user) { create(:user) }
  let(:address_path) { "/addresses/#{user.id}/edit" }
  let(:result) { page }
  let(:expected_result_bad_flash) { t('address.failure') }

  before do
    visit new_user_session_path
    fill_in t('devise.placeholder.email'), with: user.email
    fill_in t('devise.placeholder.password'), with: user.password
    click_button t('devise.default.log_in')
  end

  context 'when user create new address' do
    context 'when all data valid' do
      let(:valid_first_name) { 'First' }
      let(:valid_last_name) { 'Last' }
      let(:valid_address) { 'Address' }
      let(:valid_country_before_save) { 'Ukraine' }
      let(:valid_country_after_save) { 'UA' }
      let(:valid_city) { 'City' }
      let(:valid_zip) { 330_27 }
      let(:valid_phone) { '+380982020202' }

      context 'when BillingAddress' do
        let(:expected_result_create) { t('address.create', address_type: BillingAddress.name) }

        before do
          visit address_path
          within('#billing_address') do
            fill_in t('address.label.first_name'), with: valid_first_name
            fill_in t('address.label.last_name'), with: valid_last_name
            fill_in t('address.label.address'), with: valid_address
            select valid_country_before_save, from: t('address.label.country')
            fill_in t('address.label.city'), with: valid_city
            fill_in t('address.label.zip'), with: valid_zip
            fill_in t('address.label.phone'), with: valid_phone
            click_button(t('address.label.button_submit'))
          end
        end

        it 'give flash You create your BillinAddress' do
          expect(result).to have_text(expected_result_create)
        end

        it 'create billing_address with given data' do
          expect(user.billing_address.first_name).to eq(valid_first_name)
          expect(user.billing_address.last_name).to eq(valid_last_name)
          expect(user.billing_address.address).to eq(valid_address)
          expect(user.billing_address.country).to eq(valid_country_after_save)
          expect(user.billing_address.city).to eq(valid_city)
          expect(user.billing_address.zip).to eq(valid_zip)
          expect(user.billing_address.phone).to eq(valid_phone)
        end

        it 'redirect to home page' do
          expect(result).to have_current_path(root_path)
        end
      end

      context 'when ShippingAddress' do
        let(:expected_result_create) { t('address.create', address_type: ShippingAddress.name) }

        before do
          visit address_path
          within('#shipping_address') do
            fill_in t('address.label.first_name'), with: valid_first_name
            fill_in t('address.label.last_name'), with: valid_last_name
            fill_in t('address.label.address'), with: valid_address
            select valid_country_before_save, from: t('address.label.country')
            fill_in t('address.label.city'), with: valid_city
            fill_in t('address.label.zip'), with: valid_zip
            fill_in t('address.label.phone'), with: valid_phone
            click_button(t('address.label.button_submit'))
          end
        end

        it 'give flash you create your ShippingAddress' do
          expect(result).to have_text(expected_result_create)
        end

        it 'create shipping_address with given data' do
          expect(user.shipping_address.first_name).to eq(valid_first_name)
          expect(user.shipping_address.last_name).to eq(valid_last_name)
          expect(user.shipping_address.address).to eq(valid_address)
          expect(user.shipping_address.country).to eq(valid_country_after_save)
          expect(user.shipping_address.city).to eq(valid_city)
          expect(user.shipping_address.zip).to eq(valid_zip)
          expect(user.shipping_address.phone).to eq(valid_phone)
        end

        it 'redirect to home page' do
          expect(result).to have_current_path(root_path)
        end
      end
    end

    context 'when data not valid' do
      let(:invalid_first_name) { '1231' }
      let(:invalid_last_name) { '1231' }
      let(:invalid_address) { '@@Address' }
      let(:invalid_city) { '' }
      let(:invalid_zip) { '11@1231' }
      let(:invalid_phone) { '380982020202' }

      let(:result_for_not_create) { user.billing_address }

      let(:expected_result_first_name) { t('address.validation.first_name') }
      let(:expected_result_last_name) { t('address.validation.last_name') }
      let(:expected_result_address) { t('address.validation.address') }
      let(:expected_result_city) { t('address.validation.city') }
      let(:expected_result_zip) { t('address.validation.zip') }
      let(:expected_result_phone) { t('address.validation.phone') }

      before do
        visit address_path
        within('#billing_address') do
          fill_in t('address.label.first_name'), with: invalid_first_name
          fill_in t('address.label.last_name'), with: invalid_last_name
          fill_in t('address.label.address'), with: invalid_address
          fill_in t('address.label.city'), with: invalid_city
          fill_in t('address.label.zip'), with: invalid_zip
          fill_in t('address.label.phone'), with: invalid_phone
          click_button(t('address.label.button_submit'))
        end
      end

      it 'give flash something went wrong' do
        expect(result).to have_text(expected_result_bad_flash)
      end

      it 'give message about invalid first_name' do
        expect(result).to have_text(expected_result_first_name)
      end

      it 'give message about invalid last_name' do
        expect(result).to have_text(expected_result_last_name)
      end

      it 'give message about invalid address' do
        expect(result).to have_text(expected_result_address)
      end

      it 'give message about invalid zip' do
        expect(result).to have_text(expected_result_zip)
      end

      it 'give message about invalid phone' do
        expect(result).to have_text(expected_result_phone)
      end

      it 'give message about invalid city' do
        expect(result).to have_text(expected_result_city)
      end

      it 'not create billing_address' do
        expect(result_for_not_create).to be_nil
      end
    end
  end

  context 'when user want update some address' do
    let(:user) { address.user }
    let!(:address) { create(:address, :billing_address) }
    let(:before_update_first_name) { address.first_name }

    context 'when all data valid' do
      let(:for_update_valid_first_name) { 'First' }
      let(:address_path) { "/addresses/#{user.id}/edit" }
      let(:result_for_first_name) { User.find(user.id).billing_address.first_name }
      let(:expected_result_update_flash) { t('address.update', address_type: BillingAddress.name) }

      context 'when BillingAddress' do
        before do
          visit address_path
          within('#billing_address') do
            fill_in t('address.label.first_name'), with: for_update_valid_first_name
            click_button(t('address.label.button_submit'))
          end
        end

        it 'give flash you update your BillingAddress' do
          expect(result).to have_text(expected_result_update_flash)
        end

        it 'update first_name' do
          expect(result_for_first_name).not_to eq(before_update_first_name)
          expect(result_for_first_name).to eq(for_update_valid_first_name)
        end
      end
    end

    context 'when user want update address but data not valid' do
      let(:for_update_invalid_first_name) { 'Anton@' }
      let(:address_path) { "/addresses/#{user.id}/edit" }
      let(:result_for_first_name) { user.billing_address.first_name }

      before do
        visit address_path
        within('#billing_address') do
          fill_in t('address.label.first_name'), with: for_update_invalid_first_name
          click_button(t('address.label.button_submit'))
        end
      end

      it 'give flash somethind went wrong' do
        expect(result).to have_text(expected_result_bad_flash)
      end

      it 'not update first_name' do
        expect(result_for_first_name).not_to eq(for_update_invalid_first_name)
      end
    end
  end
end
