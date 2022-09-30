# frozen_string_literal: true

RSpec.describe 'View', type: :feature do
  let!(:admin_user) { create(:admin_user) }
  let!(:author) { create(:author) }

  let(:result) { page }

  let(:expected_result_name) { author.name }
  let(:expected_result_created_at) { author.created_at.strftime('%B %d, %Y %H:%M') }
  let(:expected_result_updated_at) { author.updated_at.strftime('%B %d, %Y %H:%M') }

  before do
    login_admin(admin_user)
    visit admin_author_path(author.id)
  end

  it 'admin can see author.name' do
    expect(result).to have_text(expected_result_name)
  end

  it 'admin can see author.created_at' do
    expect(result).to have_text(expected_result_created_at)
  end

  it 'admin can see author.updated_at' do
    expect(result).to have_text(expected_result_updated_at)
  end
end
