# frozen_string_literal: true

RSpec.describe Review, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'Table columns' do
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:status).of_type(:integer).with_options(default: :unprocessed) }
    it { is_expected.to have_db_column(:text).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:rating).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:book_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  end

  describe 'Table index' do
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:book_id) }
  end
end
