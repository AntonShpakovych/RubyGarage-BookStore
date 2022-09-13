# frozen_string_literal: true

RSpec.describe 'Home page', type: :feature do
  let(:result) { page }
  let(:expected_result1) { t('home.partials.welcome.welcome_title') }
  let(:expected_result2) { t('home.partials.welcome.welcome_description') }
  let(:expected_result3) { t('home.partials.best_sellers.title_best_sellers') }
  let(:expected_result4) { t('home.partials.carousel.button_buy_now') }
  let(:expected_result5) { t('home.partials.welcome.button_get_started') }

  before { visit root_path }

  it 'User open site and see home page' do
    expect(result).to have_text(expected_result1)
    expect(result).to have_text(expected_result2)
    expect(result).to have_text(expected_result3)
    expect(result).to have_button(expected_result4)
    expect(result).to have_link(expected_result5)
  end

  context 'when user click on button get started' do
    let(:catalog_path) { books_path }
    let(:expected_result) { catalog_path }

    before { find_link(:href => catalog_path).click }

    it 'render catalog' do
      expect(result).to have_current_path(expected_result, ignore_query: true)
    end
  end

  describe 'Navigation' do
    let(:category1) { create(:category) }
    let(:category2) { create(:category) }
    let(:catalog_path) { books_path }

    before do
      find_link('partials.desktop.navigation.navigation_shop').click
      find_link(category_name).click
    end

    Category.all.map(&:name).each do |category_name|
      context "when user choose #{category_name} category" do
        it 'render catalog with this category' do
          expect(result).to have_current_path(expected_result, ignore_query: true)
        end
      end
    end
  end

  context 'when user is not sign in' do
    let(:expected_result_sign_up) { t('devise.default.sign_up') }
    let(:expected_result_log_in) { t('devise.default.log_in') }

    it 'in navigation user see Sign up' do
      expect(result).to have_link(expected_result_sign_up)
    end

    it 'in navigation user see Log in' do
      expect(result).to have_link(expected_result_log_in)
    end
  end

  context 'when user is sign in' do
    let(:test_email) { 'test@email.email' }
    let(:password) { 'somepassword123' }
    let(:confirmation_password) { password }

    let(:expected_result_log_out) { t('devise.default.log_out') }
    let(:expected_result_settings) { t('partials.desktop.navigation.navigation_settings') }
    let(:expected_result_orders) { t('partials.desktop.navigation.navigation_orders') }

    before do
      visit new_user_registration_path
      click_link t('devise.default.sign_up'), match: :first
      fill_in 'Email', with: test_email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation_password
      click_button t('devise.default.sign_up')
    end

    it 'in navigation user see Log out' do
      expect(result).to have_link(expected_result_log_out)
    end

    it 'in navigation user see Settings' do
      expect(result).to have_link(expected_result_settings)
    end

    it 'in navigation user see Orders' do
      expect(result).to have_link(expected_result_orders)
    end
  end
end
