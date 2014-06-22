class HB::Importing::BookImport

  FEED_URL = "http://hb-feed.herokuapp.com/books.json"

  def self.str_to_json(string)
    JSON.parse(string)
  end

  def self.get_feed_content(http_client, feed_url = FEED_URL)
    http_client.get(feed_url)
  end

  def self.books_feed
    str_to_json(
      get_feed_content(Http.new)
    )
  end

end
