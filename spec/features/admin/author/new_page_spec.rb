# frozen_string_literal: true

RSpec.describe 'New page', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let(:author) { 'New Author' }

  before do
    login_admin(admin_user)
    visit new_admin_author_path
  end

  context 'when admin fill all data and click Create Author' do
    let(:expected_result_message) { find('div', class: 'flash flash_notice').text }
    let(:result) { page }
    let(:result_author) { Author.first.name }

    before do
      within('#new_author') do
        fill_in 'author[name]', with: author
        find('#author_submit_action input').click
      end
    end

    it 'show message about good create' do
      expect(result).to have_text(expected_result_message)
    end

    it 'admin create new author' do
      expect(result_author).to eq(author)
    end
  end

  context 'when admin click cancel' do
    let(:result_author) { Author.all.blank? }

    before do
      within('#new_author') do
        fill_in 'author[name]', with: author
        find('.cancel a').click
      end
    end

    it 'admin cancel create new author' do
      expect(result_author).to be_truthy
    end
  end
end
