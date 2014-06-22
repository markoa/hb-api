class Book < ActiveRecord::Base

  validates :title, :presence => true
  validates :url, :presence => true, :uniqueness => true
  validates :cover_url, :presence => true
  validates :description, :presence => true
  validates :publisher, :presence => true

  def self.create_from_hash(book_hash)
    create!(
      :title =>       book_hash["title"],
      :description => book_hash["description"],
      :url =>         book_hash["url"],
      :cover_url =>   book_hash["cover-url"],
      :publisher =>   book_hash["publisher"]
    )
  end

  def self.import_from_feed
    HB::Importing::BookImport.books_feed.each do |book|
      begin
        create_from_hash(book)
      rescue ActiveRecord::RecordInvalid
      end
    end
  end
end
