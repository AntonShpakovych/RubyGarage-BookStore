# frozen_string_literal: true

RSpec.describe 'Sign up', type: :feature do
  context 'when email unique and confirm password like a password' do
    let(:test_email) { FFaker::Internet.email }
    let(:test_password) { FFaker::Internet.password }
    let(:confirmation_password) { test_password }

    before do
      visit new_user_registration_path
      fill_in t('devise.placeholder.email'), with: test_email
      fill_in t('devise.placeholder.password'), with: test_password
      fill_in t('devise.placeholder.confirm_password'), with: confirmation_password
      click_button t('devise.default.sign_up')
    end

    it 'registration new user and redirect to root path' do
      expect(User.all.length).to eq(1)
      expect(User.all.first.email).to eq(test_email)
      expect(page).to have_current_path(root_path)
    end
  end

  context 'when email not unique' do
    let(:user_create) { create(:user) }
    let(:test_email) { user_create.email }
    let(:test_password) { FFaker::Internet.password }
    let(:confirmation_password) { test_password }

    before do
      user_create
      visit new_user_registration_path
      fill_in t('devise.placeholder.email'), with: test_email
      fill_in t('devise.placeholder.password'), with: test_password
      fill_in t('devise.placeholder.confirm_password'), with: confirmation_password
      click_button t('devise.default.sign_up')
    end

    it 'give u message about bad email' do
      expect(page).to have_text(t('devise.default.email_not_uniq'))
    end
  end

  context 'when confirm password not like a password' do
    let(:test_email) { FFaker::Internet.email }
    let(:test_password) { FFaker::Internet.password }
    let(:confirmation_password) { FFaker::Internet.password }

    before do
      visit new_user_registration_path
      fill_in t('devise.placeholder.email'), with: test_email
      fill_in t('devise.placeholder.password'), with: test_password
      fill_in t('devise.placeholder.confirm_password'), with: confirmation_password
      click_button t('devise.default.sign_up')
    end

    it 'give u message about bad confirm password' do
      expect(page).to have_text(t('devise.default.bad_password_confirmation'))
    end
  end
end
