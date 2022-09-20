# frozen_string_literal: true

RSpec.describe 'View page', type: :feature do
  let!(:admin_user) { create(:admin_user)  }
  let!(:category) { create(:category) }

  let(:result) { page }

  let(:expected_result_name) { category.name }
  let(:expected_result_created_at) { category.created_at.strftime('%B %d, %Y %H:%M') }
  let(:expected_result_updated_at) { category.updated_at.strftime('%B %d, %Y %H:%M') }

  before do
    login_admin(admin_user)
    visit admin_category_path(category.id)
  end

  it 'admin can see category.name' do
    expect(result).to have_text(expected_result_name)
  end

  it 'admin can see category.created_at' do
    expect(result).to have_text(expected_result_created_at)
  end

  it 'admin can see category.updated_at' do
    expect(result).to have_text(expected_result_updated_at)
  end
end
