module ExchangeRestApi
  class Endpoint
    attr_reader :endpoint_type, :exchange, :market

    EXCHANGE_MAPPING = {
      'bittrex' => Bittrex,
      'bitfinex' => Bitfinex
    }

    def initialize(endpoint_type:, exchange:, market:)
      @endpoint_type = endpoint_type
      @exchange = EXCHANGE_MAPPING[exchange]
      @market = market

      raise "ExchangeNotSupported #{exchange}" if !self.exchange
    end

    def to_s
      exchange.new.send(endpoint_type, market)
    end


  end
end
