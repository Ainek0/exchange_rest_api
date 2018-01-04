NONCE = Time.now.to_i

TICKER_ENDPOINT = "/public/getticker"
ORDERBOOK_ENDPOINT = '/public/getorderbook'
MARKETHISTORY_ENDPOINT = '/public/getmarkethistory'
MARKETS_ENDPOINT = '/public/getmarkets'

ORDERS_ENDPOINT = "/market/getopenorders"
BALANCES_ENDPOINT = "/account/getbalances"
BUY_ENDPOINT = "/market/buylimit"
SELL_ENDPOINT = "/market/selllimit"
CANCEL_ENDPOINT = "/market/cancel"

module ExchangeRestApi
  class Bittrex
    attr_accessor :host

    def initialize(host)
      @host = host
    end

    def request(uri, apisign = nil)
      uri
    end
    
    def public_request(endpoint, params = {})
      request(uri(endpoint, params).to_s)
    end

    def market_request(endpoint, params = {})
      params = { 'apikey' => KEY, 'nonce' => NONCE }.merge(params)
      uri = uri(endpoint, params)
      apisign = apisign(uri.to_s)
      request(uri, apisign)
    end

    def balance
      market_request(BALANCES_ENDPOINT)
    end

    def last_price
      public_request(TICKER_ENDPOINT, { 'market' => PAIR })
    end

    def ticker(pair = PAIR)
      public_request(TICKER_ENDPOINT, { 'market' => pair })
    end

    def orderbook(pair = PAIR)
      public_request(ORDERBOOK_ENDPOINT, { 'market' => pair, 'type' => 'both', 'depth' => 50 })
    end

    def markethistory(pair = PAIR)
      public_request(MARKETHISTORY_ENDPOINT, { 'market' => pair })
    end

    def markets
      public_request(MARKETS_ENDPOINT, {})
    end

    def buy_or_sell(endpoint, quantity, rate)
      market_request(endpoint, { 'market' => PAIR, 'quantity' => quantity, 'rate' => rate })
    end

    def buy(quantity, rate)
      puts "!!\tBUY #{PAIR}\t\t#{quantity} @ #{rate.trade}"
      buy_or_sell(BUY_ENDPOINT, quantity, rate.trade)
    end

    def sell(quantity, rate)
      puts "!!\tSELL #{PAIR}\t\t#{quantity} @ #{rate.trade}"
      buy_or_sell(SELL_ENDPOINT, quantity, rate.trade)
    end

    def cancel(uuid)
      puts "CANCEL #{uuid}"
    end

    def apisign(url)
      OpenSSL::HMAC.hexdigest('sha512', SECRET, url)
    end

    def uri(endpoint, params = {})
      query = URI.encode_www_form(params.to_a)
      URI.parse("#{host}#{endpoint}?#{query}")
    end
  end
end
