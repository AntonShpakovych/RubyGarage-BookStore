# frozen_string_literal: true

RSpec.describe 'Forgot password', type: :feature do
  let(:user) { create(:user) }

  let(:result) { page }
  let(:expected_result) { t('devise.passwords.send_instructions') }

  before do
    user
    visit new_user_password_path
    fill_in t('devise.placeholder.email'), with: user.email
    click_button t('devise.default.send_email_instructions_submit')
  end

  it 'says that you need to check your email' do
    expect(result).to have_text(expected_result)
  end

  describe 'change password' do
    let(:new_password) { FFaker::Internet.password }

    let(:result) { page }
    let(:expected_result) { t('devise.passwords.updated') }

    before do
      visit edit_user_password_path(reset_password_token: user.send_reset_password_instructions)
      fill_in t('devise.placeholder.password'), with: new_password
      fill_in t('devise.placeholder.confirm_password'), with: new_password
      click_button t('devise.default.change_your_password_submit')
    end

    it 'change your password' do
      expect(result).to have_text(expected_result)
    end
  end
end
