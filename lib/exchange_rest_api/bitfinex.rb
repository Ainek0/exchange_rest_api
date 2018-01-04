module ExchangeRestApi
  class Bitfinex
    attr_accessor :host

    TICKER_ENDPOINT = "/pubticker/%{market}"

    def initialize(host = 'https://api.bitfinex.com/v1')
      @host = host
    end

    def request(uri, apisign = nil)
      uri
    end
    
    def public_request(endpoint, params = {})
      request(uri(endpoint, params).to_s)
    end

    def ticker(pair = PAIR)
      public_request(TICKER_ENDPOINT % { 'market': pair })
    end

    def uri(endpoint, params = {})
      query = URI.encode_www_form(params.to_a)
      URI.parse("#{host}#{endpoint}?#{query}")
    end
  end
end

