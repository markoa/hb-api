class Http

  AGENT_NAME = "HB-API"

  def get(url)
    client.get_content(url)
  end

  private

  def client
    @client ||= HTTPClient.new(:agent_name => AGENT_NAME)
  end
end
