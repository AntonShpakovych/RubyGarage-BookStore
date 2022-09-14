# frozen_string_literal: true

RSpec.describe AddressForm, type: :model do
  describe 'Create' do
    let!(:current_user) { create(:user) }
    let(:params_good) do
      {
        first_name: 'Anton',
        last_name: 'Shpakovych',
        address: 'Some address',
        city: 'Rivne',
        country: 'UA',
        zip: 330_27,
        phone: '+380982018658',
        type: BillingAddress.name
      }
    end
    let!(:address_initialize_good) { Address.find_or_initialize_by(user_id: current_user.id, type: params_good[:type]) }

    context 'when params data valid' do
      let!(:result_for_check_created_model) { described_class.new(address_initialize_good, params_good).save }
      let(:expected_result_for_check_class_created_model) { BillingAddress }

      let!(:result_for_check_save_model) { Address.pluck(:id).include?(result_for_check_created_model.id) }

      it 'stores params attributes in similar model attributes' do
        params_good.each do |key, value|
          expect(result_for_check_created_model[key]).to eq(value)
        end
      end

      it 'save model' do
        expect(result_for_check_save_model).to be_truthy
      end

      it 'return model with correct type' do
        expect(result_for_check_created_model).to be_kind_of(expected_result_for_check_class_created_model)
      end
    end

    context 'when params have invalid data' do
      let!(:result_for_check_created_model) { described_class.new(address_initialize_good, {}).save }

      it 'return nil when invalid params' do
        expect(result_for_check_created_model).to be_nil
      end
    end
  end

  describe 'Update' do
    let!(:create_address) { create(:address, :billing_address) }
    let!(:current_user) { create_address.user }

    context 'when params valid' do
      let(:params_good_update_first_name) do
        { first_name: 'Firstupdate',
          last_name: create_address.last_name,
          address: create_address.address,
          city: create_address.city,
          country: create_address.country,
          zip: create_address.zip,
          phone: create_address.phone,
          type: create_address.type }
      end

      let!(:initialize_address) do
        Address.find_or_initialize_by(user_id: current_user.id, type: params_good_update_first_name[:type])
      end

      let(:result_for_check_update_model) do
        described_class.new(initialize_address, params_good_update_first_name).save
      end

      it 'update first_name' do
        expect(result_for_check_update_model.first_name).to eq(params_good_update_first_name[:first_name])
      end

      it 'return model' do
        expect(result_for_check_update_model).to be_kind_of(BillingAddress)
      end
    end
  end

  describe 'Validation' do
    let!(:current_user) { create(:user) }
    let!(:initialize_address) { Address.find_or_initialize_by(user_id: current_user.id, type: BillingAddress.name) }

    before { create_form.save }

    context 'when bad first_name' do
      let(:params_bad_first_name) { { first_name: 'First1' } }
      let(:create_form) { described_class.new(initialize_address, params_bad_first_name) }

      let(:result_for_first_name_validation) do
        create_form.errors[:first_name].include?(t('address.validation.first_name'))
      end

      it 'validation first_name by regex' do
        expect(result_for_first_name_validation).to be_truthy
      end
    end

    context 'when bad last_name' do
      let(:params_bad_last_name) { { last_name: 'Last1' } }
      let(:create_form) { described_class.new(initialize_address, params_bad_last_name) }

      let(:result_for_last_name_validation) do
        create_form.errors[:last_name].include?(t('address.validation.last_name'))
      end

      it 'validation last_name by regex' do
        expect(result_for_last_name_validation).to be_truthy
      end
    end

    context 'when bad address' do
      let(:params_bad_address) { { address: 'Address@!' } }
      let(:create_form) { described_class.new(initialize_address, params_bad_address) }

      let(:result_for_address_validation) do
        create_form.errors[:address].include?(t('address.validation.address'))
      end

      it 'validation address by regex' do
        expect(result_for_address_validation).to be_truthy
      end
    end

    context 'when bad city' do
      let(:params_bad_city) { { city: 'City1231' } }
      let(:create_form) { described_class.new(initialize_address, params_bad_city) }

      let(:result_for_city_validation) do
        create_form.errors[:city].include?(t('address.validation.city'))
      end

      it 'validation city by regex' do
        expect(result_for_city_validation).to be_truthy
      end
    end

    context 'when bad zip' do
      let(:params_bad_zip) { { zip: '123!@' } }
      let(:create_form) { described_class.new(initialize_address, params_bad_zip) }

      let(:result_for_zip_validation) do
        create_form.errors[:zip].include?(t('address.validation.zip'))
      end

      it 'validation zip by regex' do
        expect(result_for_zip_validation).to be_truthy
      end
    end

    context 'when bad phone' do
      let(:params_bad_phone) { { country: 'UA', phone: '+1234567899' } }
      let(:create_form) { described_class.new(initialize_address, params_bad_phone) }

      let(:result_for_phone_validaiton) do
        create_form.errors[:phone].include?(t('address.validation.phone'))
      end

      it 'validation phone by regex' do
        expect(result_for_phone_validaiton).to be_truthy
      end
    end
  end
end
