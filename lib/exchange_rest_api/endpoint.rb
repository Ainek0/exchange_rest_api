module ExchangeRestApi
  class Endpoint
    attr_reader :endpoint_type, :exchange, :market

    EXCHANGE_MAPPING = {
      'bittrex' => Api::Bittrex,
      'bitfinex' => Api::Bitfinex
    }

    def initialize(endpoint_type:, exchange:, market:)
      @endpoint_type = endpoint_type
      @exchange = EXCHANGE_MAPPING[exchange]
      raise "ExchangeNotSupported #{exchange}" if !self.exchange

      @market = Market.new(
        exchange: exchange,
        normalised_market: market
      ).name
      raise "MarketNotSupported #{market}" if !self.market
    end

    def to_s
      exchange.new.send(endpoint_type, market)
    end


  end
end
