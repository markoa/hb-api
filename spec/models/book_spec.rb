require 'spec_helper'

describe Book do

  describe ".import_books_to_db" do

    BOOKS_IN_FIXTURE = 167

    context "feed includes #{BOOKS_IN_FIXTURE} books" do

      before do
        File.open("#{Rails.root}/spec/fixtures/books.json") do |f|
          @feed_content = f.read
        end

        allow(HB::Importing::BookImport).
          to receive(:get_feed_content).
          and_return(@feed_content)
      end

      it "creates #{BOOKS_IN_FIXTURE} new Book records" do
        expect { Book.import_from_feed }.
          to change(Book, :count).by(BOOKS_IN_FIXTURE)
      end

      it "doesn't create duplicates" do
        expect { 2.times { Book.import_from_feed } }.
          to change(Book, :count).by(BOOKS_IN_FIXTURE)
      end
    end
  end
end
