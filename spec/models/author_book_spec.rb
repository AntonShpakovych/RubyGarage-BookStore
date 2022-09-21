# frozen_string_literal: true

RSpec.describe AuthorBook, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'Table columns' do
    it { is_expected.to have_db_column(:book_id).of_type(:integer) }
    it { is_expected.to have_db_column(:author_id).of_type(:integer) }
  end

  describe 'Table index' do
    it { is_expected.to have_db_index(:book_id) }
    it { is_expected.to have_db_index(:author_id) }
  end
end
