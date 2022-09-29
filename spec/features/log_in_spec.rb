# frozen_string_literal: true

RSpec.describe 'Log in', type: :feature do
  let(:result) { page }

  context 'when correct user' do
    let(:user) { create(:user) }
    let(:test_email) { user.email }
    let(:password) { user.password }

    let(:expected_result) { t('devise.default.log_out') }

    before do
      user
      visit new_user_session_path
      fill_in t('devise.placeholder.email'), with: test_email
      fill_in t('devise.placeholder.password'), with: password
      click_button t('devise.default.log_in')
    end

    it 'log in into user' do
      expect(result).to have_link(expected_result)
    end
  end

  context 'when user is incorrect' do
    let(:test_email) { FFaker::Internet.email }
    let(:test_password) { FFaker::Internet.password }

    let(:expected_result) { t('devise.default.invalid_log_in') }

    before do
      visit new_user_session_path
      fill_in t('devise.placeholder.email'), with: test_email
      fill_in t('devise.placeholder.password'), with: test_password
      click_button t('devise.default.log_in')
    end

    it 'give u response invalid email or password and render log in page' do
      expect(result).to have_text(expected_result)
    end
  end
end
