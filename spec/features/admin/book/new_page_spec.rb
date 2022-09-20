# frozen_string_literal: true

RSpec.describe 'New page', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:category) { create(:category) }
  let!(:author) { create(:author) }

  let(:expected_result_book) { attributes_for(:book)[:name] }

  before do
    login_admin(admin_user)
    visit new_admin_book_path
  end

  context 'when admin fill all data and click Create Book' do
    let(:expected_result_message) { find('div', class: 'flash flash_notice').text }

    let(:result) { page }
    let(:result_book) { Book.first.name }

    before do
      within('#new_book') do
        fill_in 'book[name]', with: expected_result_book
        fill_in 'book[price]', with: attributes_for(:book)[:price]
        fill_in 'book[description]', with: attributes_for(:book)[:description]
        fill_in 'book[height]', with: attributes_for(:book)[:height]
        fill_in 'book[width]', with: attributes_for(:book)[:width]
        fill_in 'book[length]', with: attributes_for(:book)[:length]
        fill_in 'book[quantity]', with: attributes_for(:book)[:quantity]
        fill_in 'book[year_of_publication]', with: attributes_for(:book)[:year_of_publication]
        fill_in 'book[materials]', with: attributes_for(:book)[:materials]
        check(author.name)
        select category.name, from: 'book[category_id]'
        find('#book_submit_action input').click
      end
    end

    it 'show message about good create' do
      expect(result).to have_text(expected_result_message)
    end

    it 'admin create new book' do
      expect(result_book).to eq(expected_result_book)
    end
  end

  context 'when admin click cancel' do
    let(:result_book) { Book.all.blank? }

    before do
      within('#new_book') do
        fill_in 'book[name]', with: expected_result_book
        fill_in 'book[price]', with: attributes_for(:book)[:price]
        fill_in 'book[description]', with: attributes_for(:book)[:description]
        fill_in 'book[height]', with: attributes_for(:book)[:height]
        fill_in 'book[width]', with: attributes_for(:book)[:width]
        fill_in 'book[length]', with: attributes_for(:book)[:length]
        fill_in 'book[quantity]', with: attributes_for(:book)[:quantity]
        fill_in 'book[year_of_publication]', with: attributes_for(:book)[:year_of_publication]
        fill_in 'book[materials]', with: attributes_for(:book)[:materials]
        check(author.name)
        select category.name, from: 'book[category_id]'
        find('.cancel a').click
      end
    end

    it 'admin cancel create new book' do
      expect(result_book).to be_truthy
    end
  end
end
