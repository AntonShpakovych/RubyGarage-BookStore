# frozen_string_literal: true

RSpec.describe 'Privacy page', type: :feature do
  let(:user) { create(:user) }
  let(:result) { page }
  let(:privacy_path) { "users/#{user.id}" }

  before do
    visit new_user_session_path
    fill_in t('devise.placeholder.email'), with: user.email
    fill_in t('devise.placeholder.password'), with: user.password
    click_button t('devise.default.log_in')
  end

  context 'when user want update email' do
    let(:result_email) { User.find(user.id).email }
    let(:attribute) { 'email' }
    let(:expected_result_flash) { t('privacy.good_update', attribute: attribute) }

    context 'when new email valid' do
      let(:valid_email) { 'new_email@gmail.com' }

      before do
        visit privacy_path
        within('#email_form') do
          fill_in t('privacy.label.email'), with: valid_email
          click_button(t('privacy.global_names.button_submit'))
        end
      end

      it 'show flash you update your email' do
        expect(result).to have_text(expected_result_flash)
      end

      it 'change email' do
        expect(result_email).to eq(valid_email)
      end
    end

    context 'when new email not valid' do
      let(:invalid_email) { '--email@gmail.com' }
      let(:expected_result_flash) { t('privacy.bad_update') }
      let(:expected_result_validation) { t('privacy.validation.email') }
      let(:result_user_email) { User.find(user.id).email }
      let(:old_email) { user.email }
      let(:new_email) { invalid_email }

      before do
        visit privacy_path
        within('#email_form') do
          fill_in t('privacy.label.email'), with: invalid_email
          click_button(t('privacy.global_names.button_submit'))
        end
      end

      it 'show flash something went wrong' do
        expect(result).to have_text(expected_result_flash)
      end

      it 'show validation error' do
        expect(result).to have_text(expected_result_validation)
      end

      it 'not change user.email' do
        expect(result_user_email).to eq(old_email)
        expect(result_email).not_to eq(new_email)
      end
    end
  end

  context 'when user want change password' do
    context 'when user type bad old password' do
      let(:invalid_current_password) { 'somebadpassword' }
      let(:password) { 'Password' }
      let(:password_confirmation) { password }
      let(:result_for_password) { User.find(user.id).password }
      let(:expected_result_for_validation) { t('privacy.validation.password_old') }
      let(:expected_result_for_flash) { t('privacy.bad_update') }

      before do
        visit privacy_path
        within('#password_form') do
          fill_in t('privacy.label.current_password'), with: invalid_current_password
          fill_in t('privacy.label.password'), with: password
          fill_in t('privacy.label.password_confirmation'), with: password_confirmation
          click_button(t('privacy.global_names.button_submit'))
        end
      end

      it 'show flash something went wrong' do
        expect(result).to have_text(expected_result_for_flash)
      end

      it 'dont change password when old password bad' do
        expect(result_for_password).not_to eq(password)
      end

      it 'show old password validation' do
        expect(result).to have_text(expected_result_for_validation)
      end
    end

    context 'when user password confirmation != password' do
      let(:old_password) { user.password }
      let(:password) { 'Password' }
      let(:password_confirmation) { 'password' }
      let(:result_for_password_confirmation) { User.find(user.id).password }
      let(:expected_result_for_validation) { t('privacy.validation.password_confirmation') }
      let(:expected_result_for_flash) { t('privacy.bad_update') }

      before do
        visit privacy_path
        within('#password_form') do
          fill_in t('privacy.label.current_password'), with: old_password
          fill_in t('privacy.label.password'), with: password
          fill_in t('privacy.label.password_confirmation'), with: password_confirmation
          click_button(t('privacy.global_names.button_submit'))
        end
      end

      it 'give flash something went wrong' do
        expect(result).to have_text(expected_result_for_flash)
      end

      it 'show password confirmation validation' do
        expect(result).to have_text(expected_result_for_validation)
      end

      it 'not change password when password != password_confirmation' do
        expect(result_for_password_confirmation).not_to eq(password)
      end
    end

    context 'when old password okey and password == password confirmation, but password have validation error' do
      let(:current_password) { user.password }
      let(:password) { 'password' }
      let(:password_confirmation) { password }
      let(:result_for_password) { User.find(user.id).password }
      let(:expected_result_for_validation) { t('privacy.validation.password') }
      let(:expected_result_for_flash) { t('privacy.bad_update') }

      before do
        visit privacy_path
        within('#password_form') do
          fill_in t('privacy.label.current_password'), with: current_password
          fill_in t('privacy.label.password'), with: password
          fill_in t('privacy.label.password_confirmation'), with: password_confirmation
          click_button(t('privacy.global_names.button_submit'))
        end
      end

      it 'show flash something went wrong' do
        expect(result).to have_text(expected_result_for_flash)
      end

      it 'show validation password' do
        expect(page).to have_text(expected_result_for_validation)
      end

      it 'not change password, when new password not pass validation' do
        expect(result_for_password).not_to eq(password)
      end
    end

    context 'when all data valid' do
      let(:current_password) { user.password }
      let(:password) { 'Password1' }
      let(:password_confirmation) { password }
      let(:result_for_password) { User.find(user.id).valid_password?(password) }
      let(:expected_result_for_flash) { t('privacy.good_update', attribute: 'password') }

      before do
        visit privacy_path
        within('#password_form') do
          fill_in t('privacy.label.current_password'), with: current_password
          fill_in t('privacy.label.password'), with: password
          fill_in t('privacy.label.password_confirmation'), with: password_confirmation
          click_button(t('privacy.global_names.button_submit'))
        end
      end

      it 'show flash you update password' do
        expect(result).to have_text(expected_result_for_flash)
      end

      it 'change password' do
        expect(result_for_password).to be_truthy
      end
    end
  end

  context 'when user want delete account' do
    context 'when checkbox not checked' do
      let(:result_link) do
        within('#delete_account_form') do
          page.find_link(t('privacy.global_names.button_submit_remove_account'))[:class]
        end
      end
      let(:expected_result) { 'disabled' }

      before { visit privacy_path }

      it 'link for delete_account disable' do
        expect(result_link).to include(expected_result)
      end
    end

    context 'when checkbox checked' do
      let(:result) { User.pluck(:id) }
      let(:expected_result) { user.id }

      before do
        visit privacy_path
        page.find('.checkbox-input', :visible => false).set(true)
        page.find_link(t('privacy.global_names.button_submit_remove_account')).click
      end

      it 'link for delete_account not disable' do
        expect(result).not_to include(expected_result)
      end
    end
  end
end
