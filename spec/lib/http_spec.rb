describe Http do


  describe "#get" do

    it "forwards to HTTPClient#get_content" do
      expect_any_instance_of(HTTPClient).to receive(:get_content).with("http://test.com")

      Http.new.get("http://test.com")
    end
  end
end
