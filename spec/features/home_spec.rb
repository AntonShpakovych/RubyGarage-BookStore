# frozen_string_literal: true

RSpec.describe 'Home page', type: :feature do
  before { visit root_path }

  it 'User open site and see home page' do
    expect(page).to have_text(t('home.partials.welcome.welcome_title'))
    expect(page).to have_text(t('home.partials.welcome.welcome_description'))
    expect(page).to have_text(t('home.partials.best_sellers.title_best_sellers'))
    expect(page).to have_text(t('home.partials.best_sellers.title_best_sellers'))
    expect(page).to have_button(t('home.partials.carousel.button_buy_now'))
    expect(page).to have_link(t('home.partials.welcome.button_get_started'))
  end

  context 'when user click on button get started' do
    let(:catalog_path) { books_path }

    it 'render catalog' do
      find_link(:href => catalog_path).click
      expect(page).to have_current_path(catalog_path, ignore_query: true)
    end
  end

  describe 'Navigation' do
    let(:category1) { create(:category) }
    let(:category2) { create(:category) }
    let(:catalog_path) { books_path }

    before do
      category1
      category2
    end

    Category.all.map(&:name).each do |category_name|
      find_link('partials.desktop.navigation.navigation_shop').click
      find_link(category_name).click
      context "when user choose #{category_name} category" do
        it 'render catalog with this category' do
          expect(page).to have_current_path(catalog_path, ignore_query: true)
        end
      end
    end
  end

  context 'when user is not sign in' do
    it 'in navigation user see Sign up' do
      expect(page).to have_link(t('devise.default.sign_up'))
    end

    it 'in navigation user see Log in' do
      expect(page).to have_link(t('devise.default.log_in'))
    end
  end

  context 'when user is sign in' do
    let(:test_email) { 'test@email.email' }
    let(:password) { 'somepassword123' }
    let(:confirmation_password) { password }

    before do
      visit new_user_registration_path
      click_link t('devise.default.sign_up'), match: :first
      fill_in 'Email', with: test_email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation_password
      click_button t('devise.default.sign_up')
    end

    it 'in navigation user see Log out' do
      expect(page).to have_link(t('devise.default.log_out'))
    end

    it 'in navigation user see Settings' do
      expect(page).to have_link(t('partials.desktop.navigation.navigation_settings'))
    end

    it 'in navigation user see Orders' do
      expect(page).to have_link(t('partials.desktop.navigation.navigation_orders'))
    end
  end
end
