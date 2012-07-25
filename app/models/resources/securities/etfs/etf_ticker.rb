class EtfTicker < CbApiResource
  def self.search_name(term)
    url = URI("http://localhost:4567/etf_tickers.json?search=true&by=name&term=#{term}")
    data = Net::HTTP.get(url)
    json = JSON.parse(data)    
  end

  def self.search_symbol(term)
    url = URI("http://localhost:4567/etf_tickers.json?search=true&by=symbol&term=#{term}")
    data = Net::HTTP.get(url)
    json = JSON.parse(data)   
  end
end
