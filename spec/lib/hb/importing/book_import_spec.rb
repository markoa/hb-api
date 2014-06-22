describe HB::Importing::BookImport do

  describe ".str_to_json" do

    it "returns a JSON hash from a given string" do
      expect(
        HB::Importing::BookImport.str_to_json(
          "{ \"hello\": \"world\" }"
        )
      ).to eql({ "hello" => "world" })
    end
  end

  describe ".get_feed_content" do

    it "returns a response body string" do
      http_client = double
      http_client.stub(:get => "content")

      expect(
        HB::Importing::BookImport.get_feed_content(http_client)
      ).to eql("content")
    end
  end

end
