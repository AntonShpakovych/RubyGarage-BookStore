# frozen_string_literal: true

RSpec.describe 'Index page', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:category) { create(:category) }

  let(:link_view) { find_link(class: 'view_link member_link') }
  let(:link_edit) { find_link(class: 'edit_link member_link') }
  let(:link_delete) { find_link(class: 'delete_link member_link') }
  let(:link_create) { find_link(href: '/admin/categories/new') }

  let(:links) { [link_view, link_edit, link_delete, link_create] }
  let(:expected_result_name) { category.name }
  let(:expected_result_id) { category.id }
  let(:result) { page }

  before do
    login_admin(admin_user)
    visit admin_categories_path
  end

  it 'each category item has name' do
    expect(result).to have_text(expected_result_name)
  end

  it 'each category item has id' do
    expect(result).to have_text(expected_result_id)
  end

  it 'each category item has Edit, View, Delete' do
    links.each do |link|
      expect(result.body).to have_link(link.text)
    end
  end

  context 'when admin click some link' do
    let(:result_current_path) { result.current_path }

    context 'when click view' do
      let(:expected_result_current_path) { admin_category_path(category.id) }

      before { link_view.click }

      it 'render view page' do
        expect(result_current_path).to eq(expected_result_current_path)
      end
    end

    context 'when click edit' do
      let(:expected_result_current_path) { edit_admin_category_path(category.id) }

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
      let(:expected_result_current_path) { new_admin_category_path }

      before { link_create.click }

      it 'render create page' do
        expect(result_current_path).to eq(expected_result_current_path)
      end
    end
  end
end
