# frozen_string_literal: true

RSpec.describe OrderItem, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:book) }
  end

  describe 'Table columns' do
    it { is_expected.to have_db_column(:quantity).of_type(:integer).with_options(null: false) }
  end

  describe 'Table index' do
    it { is_expected.to have_db_index(:book_id) }
    it { is_expected.to have_db_index(:order_id) }
  end
end
