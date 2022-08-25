# frozen_string_literal: true

RSpec.describe 'Log in', type: :feature do
  let(:user) { create(:user) }
  let(:test_email) { user.email }
  let(:password) { user.password }

  before do
    user
    visit new_user_session_path
    fill_in 'Email', with: test_email
    fill_in 'Password', with: password
    click_button t('devise.defolt.log_in')
  end

  it 'log in into user' do
    expect(page).to have_link(t('devise.defolt.log_out'))
  end
end
