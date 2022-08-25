# frozen_string_literal: true

RSpec.describe 'Sign up', type: :feature do
  let(:test_email) { 'test@email.email' }
  let(:password) { 'somepassword123' }
  let(:confirmation_password) { password }

  before do
    visit new_user_registration_path
    fill_in 'Email', with: test_email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: confirmation_password
    click_button t('devise.defolt.sign_up')
  end

  it 'registration new user and redirect to root path' do
    expect(User.all.length).to eq(1)
    expect(User.all.first.email).to eq(test_email)
    expect(page).to have_current_path(root_path)
  end
end
