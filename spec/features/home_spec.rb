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
    expect(page).to have_text(expected_result1)
    expect(page).to have_text(expected_result2)
    expect(page).to have_text(expected_result3)
    expect(page).to have_button(expected_result4)
    expect(page).to have_link(expected_result5)
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
    let!(:category1) { create(:category) }
    let!(:category2) { create(:category) }
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
end
