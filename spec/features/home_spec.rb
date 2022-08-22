# frozen_string_literal: true

RSpec.describe 'Home page', type: :feature do
  before { visit root_path }

  it 'User open site and see home page' do
    expect(page).to have_text(t('home.partials.welcome.welcome_title'))
    expect(page).to have_text(t('home.partials.welcome.welcome_description'))
    expect(page).to have_text(t('home.partials.best_sellers.title_best_sellers'))
    expect(page).to have_text(t('home.partials.best_sellers.title_best_sellers'))
    expect(page.has_button?(t('home.partials.carousel.button_buy_now'))).to be(true)
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
    expect(page.has_button?(t('home.partials.welcome.button_get_started'))).to be(true)
  end
end
