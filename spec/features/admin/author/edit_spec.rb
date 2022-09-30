# frozen_string_literal: true

RSpec.describe 'Edit', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:author) { create(:author) }

  let(:new_name) { 'New author name' }
  let(:expected_result_button) { find('#author_submit_action input').value }
  let(:expected_result_link) { find('.cancel a').text }
  let(:result) { page }

  before do
    login_admin(admin_user)
    visit edit_admin_author_path(author)
  end

  it 'edit page show author name' do
    expect(result).to have_text(author.name)
  end

  it 'page has button Update Author' do
    expect(result).to have_button(expected_result_button)
  end

  it 'page has button Cancel' do
    expect(result).to have_link(expected_result_link)
  end

  context 'when admin want update author and click Update Author' do
    before do
      within('#edit_author') do
        fill_in 'author[name]', with: new_name
        click_button(expected_result_button)
      end
    end

    it 'change name' do
      expect(result).to have_text(new_name)
    end
  end

  context 'when admin want update but click Cancel' do
    before do
      within('#edit_author') do
        fill_in 'author[name]', with: new_name
        click_link(expected_result_link)
      end
    end

    it 'not change name' do
      expect(result).not_to have_text(new_name)
    end
  end
end
