# frozen_string_literal: true

RSpec.describe 'Edit page', type: :feature do
  let!(:admin_user) { create(:admin_user)  }
  let!(:category) { create(:category) }

  let(:new_name) { 'New category name' }
  let(:expected_result_button) { find('#category_submit_action input').value }
  let(:expected_result_link) { find('.cancel a').text }
  let(:result) { page }

  before do
    login_admin(admin_user)
    visit edit_admin_category_path(category)
  end

  it 'edit page show category name' do
    expect(result).to have_text(category.name)
  end

  it 'page has button Update Category' do
    expect(result).to have_button(expected_result_button)
  end

  it 'page has button Cancel' do
    expect(result).to have_link(expected_result_link)
  end

  context 'when admin want update category and click Update Category' do
    before do
      within('#edit_category') do
        fill_in 'category[name]', with: new_name
        click_button(expected_result_button)
      end
    end

    it 'change name' do
      expect(result).to have_text(new_name)
    end
  end

  context 'when admin want update but click Cancel' do
    before do
      within('#edit_category') do
        fill_in 'category[name]', with: new_name
        click_link(expected_result_link)
      end
    end

    it 'not change name' do
      expect(result).not_to have_text(new_name)
    end
  end
end
