# frozen_string_literal: true

RSpec.describe 'View page', type: :feature do
  let!(:admin_user) { create(:admin_user)  }
  let!(:book) { create(:book) }

  let(:result) { page }

  let(:expected_result_created_at) { book.created_at.strftime('%B %d, %Y %H:%M') }
  let(:expected_result_updated_at) { book.updated_at.strftime('%B %d, %Y %H:%M') }

  before do
    login_admin(admin_user)
    visit admin_book_path(book.id)
  end

  it 'Admin can see all data from book' do
    Book.column_names[1..] do |column|
      expect(result).to have_text(expected_result_created_at) if column == 'created_at'
      expect(result).to have_text(expected_result_updated_at) if column == 'updated_at'
      expect(result).to have_text(book.column)
    end
  end
end
