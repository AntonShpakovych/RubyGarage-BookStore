# frozen_string_literal: true

RSpec.describe AuthorsBook, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:book) }
  end
end
