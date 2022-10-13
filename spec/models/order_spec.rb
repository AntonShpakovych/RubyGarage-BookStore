# frozen_string_literal: true

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to have_one(:coupon).optional }
  end

  describe 'Table columns' do
    it { is_expected.to have_db_column(:status).of_type(:integer).with_options(default: :unprocessed) }
  end

  describe 'Table index' do
    it { is_expected.to have_db_index(:user_id) }
  end
end
