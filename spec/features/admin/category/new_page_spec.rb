# frozen_string_literal: true

RSpec.describe 'New page', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let(:category) { 'New Category' }

  before do
    login_admin(admin_user)
    visit new_admin_category_path
  end

  context 'when admin fill all data and click Create Category' do
    let(:expected_result_message) { find('div', class: 'flash flash_notice').text }
    let(:result) { page }
    let(:result_category) { Category.first.name }

    before do
      within('#new_category') do
        fill_in 'category[name]', with: category
        find('#category_submit_action input').click
      end
    end

    it 'show message about good create' do
      expect(result).to have_text(expected_result_message)
    end

    it 'admin create new category' do
      expect(result_category).to eq(category)
    end
  end

  context 'when admin click cancel' do
    let(:result_category) { Category.all.blank? }

    before do
      within('#new_category') do
        fill_in 'category[name]', with: category
        find('.cancel a').click
      end
    end

    it 'admin cancel create new category' do
      expect(result_category).to be_truthy
    end
  end
end
