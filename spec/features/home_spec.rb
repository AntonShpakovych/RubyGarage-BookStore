# frozen_string_literal: true

RSpec.describe 'Home page', type: :feature do
  before { visit root_path }

  it 'User open site and see home page' do
    expect(page).to have_text(t('home.partials.welcome.welcome_title'))
    expect(page).to have_text(t('home.partials.welcome.welcome_description'))
    # expect(page).to have_text(t('.title_best_sellers'))
    # expect(page).to have_text(t('.title_best_sellers'))
    # expect(page.has_button?(t('.button_get_started'))).to be(true)
  end
end
