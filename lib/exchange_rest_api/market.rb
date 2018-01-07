module ExchangeRestApi
  class Market
    attr_reader :exchange, :normalised_market

    EXCHANGE_MAPPING = {
      'bittrex' => Markets::Bittrex,
      'bitfinex' => Markets::Bitfinex
    }

    def initialize(exchange:, normalised_market:)
      @exchange = EXCHANGE_MAPPING[exchange]
      @normalised_market = normalised_market
    end

    def name
      exchange.new(normalised_market).name
    end

  end
end
