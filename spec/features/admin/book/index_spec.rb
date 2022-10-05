# frozen_string_literal: true

RSpec.describe 'Index', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:book) { create(:book, authors: [create(:author)]) }

  let(:link_view) { find_link(class: 'view_link member_link') }
  let(:link_edit) { find_link(class: 'edit_link member_link') }
  let(:link_delete) { find_link(class: 'delete_link member_link') }
  let(:link_create) { find_link(href: '/admin/books/new') }

  let(:links) { [link_view, link_edit, link_delete, link_create] }

  let(:expected_result_name) { book.name }
  let(:expected_result_id) { book.id }
  let(:expected_result_category) { book.category.name }
  let(:expected_result_author) { book.authors.pluck(:name).join(', ') }
  let(:expected_result_main_image) do
    /#{book.main_image}/
  end
  let(:expected_result_main_image_default) do
    /#{book_image_default}/
  end

  let(:result) { page }
  let(:result_main_image) do
    page.find('img', class: 'max-w-h-100')['src']
  end

  before do
    login_admin(admin_user)
    visit admin_books_path
  end

  it 'each book item has authors' do
    expect(result).to have_text(expected_result_author)
  end

  it 'each book item has category' do
    expect(result).to have_text(expected_result_category)
  end

  it 'each book item has name' do
    expect(result).to have_text(expected_result_name)
  end

  it 'each book item has id' do
    expect(result).to have_text(expected_result_id)
  end

  it 'each book item has Edit, View, Delete' do
    links.each do |link|
      expect(result.body).to have_link(link.text)
    end
  end

  context 'when book item have main_image' do
    it 'admin can see book.main_image' do
      expect(result_main_image).to match(expected_result_main_image)
    end
  end

  context 'when book item not have main_image' do
    let(:book) { create(:book, main_image: nil) }

    it 'admin can see default image for main_image' do
      expect(result_main_image).to match(expected_result_main_image_default)
    end
  end

  context 'when admin click some link' do
    let(:result_current_path) { result.current_path }

    context 'when click view' do
      let(:expected_result_current_path) { admin_book_path(book.id) }

      before { link_view.click }

      it 'render view page' do
        expect(result_current_path).to eq(expected_result_current_path)
      end
    end

    context 'when click edit' do
      let(:expected_result_current_path) { edit_admin_book_path(book.id) }

      before { link_edit.click }

      it 'render edit page' do
        expect(result_current_path).to eq(expected_result_current_path)
      end
    end

    context 'when click delete' do
      let(:expected_result_flash) { find('div', class: 'flash flash_notice').text }

      before { link_delete.click }

      it 'show message about good delete' do
        expect(result).to have_text(expected_result_flash)
      end
    end

    context 'when click create' do
      let(:result_current_path) { result.current_path }
      let(:expected_result_current_path) { new_admin_book_path }

      before { link_create.click }

      it 'render create page' do
        expect(result_current_path).to eq(expected_result_current_path)
      end
    end
  end
end
