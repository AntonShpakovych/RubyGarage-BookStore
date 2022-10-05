# frozen_string_literal: true

RSpec.describe Coupon, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:order).optional }
  end

  describe 'Table columns' do
    it { is_expected.to have_db_column(:code).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:discount).of_type(:float).with_options(null: false) }
  end

  describe 'Table index' do
    it { is_expected.to have_db_index(:order_id) }
  end
end
