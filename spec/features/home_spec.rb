# frozen_string_literal: true

RSpec.describe 'Home page', type: :feature do
  before { visit root_path }

  it 'User open site and see home page' do
    expect(page).to have_text(I18n.t('home.welcome_title'))
    expect(page).to have_text(I18n.t('home.welcome_description'))
    expect(page).to have_text(I18n.t('home.title_best_sellers'))
    expect(page).to have_text(I18n.t('home.title_best_sellers'))
    expect(page.has_button?(I18n.t('home.button_get_started'))).to be(true)
  end
end
