# frozen_string_literal: true

RSpec.describe CreditCard, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:order).optional }
  end

  describe 'Table columns' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:number).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:date).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:cvv).of_type(:string).with_options(null: false) }
  end

  describe 'Table index' do
    it { is_expected.to have_db_index(:order_id) }
  end
end
