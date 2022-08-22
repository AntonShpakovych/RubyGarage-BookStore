# frozen_string_literal: true

RSpec.describe BookQueries do
  describe '#call' do
    let(:categories) { Category.all }
    let(:books) { Book.all }

    describe '#by_category' do
      let(:category_1_name) { 'category1' }
      let(:category_2_name) { 'category2' }
      let(:book_category_1_count) { 5 }
      let(:book_category_2_count) { 2 }
      let(:category1) { create(:category, name: category_1_name) }
      let(:category2) { create(:category, name: category_2_name) }

      before do
        book_category_1_count.times do
          create(:book, category: Category.find(category1.id))
        end

        book_category_2_count.times do
          create(:book, category: Category.find(category2.id))
        end
      end

      context "when category not nil or not defolt (#{BookQueries::DEFAULT_CATEGORY})" do
        let(:params) { { category: category1.id } }
        let(:book_queries) { described_class.new(books, categories, params) }

        it 'change @books to @books only with cattegory from params' do
          expect { book_queries.call }.to change {
                                            book_queries.instance_variable_get(:@books).size
                                          }.from(book_category_1_count + book_category_2_count)
            .to(book_category_1_count)
        end
      end

      context "when category nil or defolt category (#{BookQueries::DEFAULT_CATEGORY})" do
        let(:params) { {} }
        let(:book_queries) { described_class.new(books, categories, params) }

        it 'not change @books, books with all category' do
          expect(book_queries.call.length).to eq(book_category_1_count + book_category_2_count)
        end
      end
    end

    describe '#by_filter' do
      let(:some_category) { create(:category) }
      let(:low_price) { 10.0 }
      let(:hight_price) { 100.0 }
      let(:first_name) { 'AAAA' }
      let(:last_name) { 'BBBB' }

      before do
        create(:book, name: first_name, price: hight_price, category: Category.find(some_category.id))
        create(:book, name: last_name, price: low_price, category: Category.find(some_category.id))
      end

      context "when filter not nil or not defolt (#{BookQueries::DEFAULT_FILTER})" do
        let(:params) { { filter: BookQueries::FILTER_KEYS.keys.fifth } }
        let(:book_queries) { described_class.new(books, categories, params) }

        it "sorting @books by #{BookQueries::FILTER_KEYS.keys.fifth}" do
          expect(book_queries.call.first.price).to eq(low_price)
        end
      end

      context "when filter nil or defolt (#{BookQueries::DEFAULT_FILTER})" do
        let(:params) { {} }
        let(:book_queries) { described_class.new(books, categories, params) }

        it "sorting @books by #{BookQueries::DEFAULT_FILTER}" do
          expect(book_queries.call.first.name).to eq(first_name)
        end
      end
    end
  end
end
