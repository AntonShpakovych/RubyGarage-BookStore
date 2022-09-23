# frozen_string_literal: true

RSpec.describe UpdatePasswordForm, type: :model do
  let!(:current_user) { create(:user) }

  before { create_form.save }

  context 'when user want update password' do
    let(:create_form) { described_class.new(current_user, params_for_password) }

    context 'when user pass bad old password' do
      let(:params_for_password) do
        { current_password: 'notoriginalpassword',
          password: 'somepassword',
          password_confirmation: 'somepassword' }
      end

      let(:result_validation_for_old_password) do
        create_form.errors[:current_password].include?(t('privacy.validation.password_old'))
      end

      it 'current password validaiton by regex' do
        expect(result_validation_for_old_password).to be_truthy
      end
    end

    context 'when old password valid but new password not valid' do
      let(:params_for_password) do
        { current_password: current_user.password,
          password: 'somebadpassword',
          password_confirmation: 'somebadpassword' }
      end

      let(:result_validation_for_new_password) do
        create_form.errors[:password].include?(t('privacy.validation.password'))
      end

      it 'password validation by regex' do
        expect(result_validation_for_new_password).to be_truthy
      end
    end

    context 'when current_password, password valid but password_confirmation invalid' do
      let(:params_for_password) do
        {
          current_password: current_user.password,
          password: 'Password1',
          password_confirmation: 'not_same_with_password'
        }
      end

      let(:result_validation_for_password_confirmation) do
        create_form.errors[:password_confirmation].include?(t('privacy.validation.password_confirmation'))
      end

      it 'password_confirmation validation by regex' do
        expect(result_validation_for_password_confirmation).to be_truthy
      end
    end

    context 'when all data valid' do
      let(:params_for_password) do
        {
          current_password: current_user.password,
          password: 'Validpassword1',
          password_confirmation: 'Validpassword1'
        }
      end

      let(:result_update_password) do
        current_user.valid_password?(params_for_password[:password])
      end

      it 'update user' do
        expect(result_update_password).to be_truthy
      end
    end
  end
end
