# frozen_string_literal: true

RSpec.describe 'Home page', type: :feature do
  before { visit root_path }

  it 'User open site and see home page' do
    expect(page).to have_text(t('home.partials.welcome.welcome_title'))
    expect(page).to have_text(t('home.partials.welcome.welcome_description'))
    expect(page).to have_text(t('home.partials.best_sellers.title_best_sellers'))
    expect(page).to have_text(t('home.partials.best_sellers.title_best_sellers'))
    expect(page.has_button?(t('home.partials.carousel.button_buy_now'))).to be(true)
    expect(page.has_button?(t('home.partials.welcome.button_get_started'))).to be(true)
  end
end
